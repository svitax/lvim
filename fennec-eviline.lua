local gl = require("galaxyline")
-- local colors = require('galaxyline.theme').default
local colors = {
	-- bg = "#32302f",
	bg = "#3c3836",
	fg = "#d4be98",
	fg_alt = "#ddc7a1",
	yellow = "#d8a657",
	cyan = "#89b482",
	green = "#a9b665",
	orange = "#e78a4e",
	magenta = "#d3869b",
	blue = "#7daea3",
	red = "#ea6962",
}

local bo = vim.bo
local condition = require("galaxyline.condition")
local gls = gl.section
-- local lsp = require("galaxyline.provider_lsp")
local buffer = require("galaxyline.provider_buffer")
gl.short_line_list = { "NvimTree", "vista", "dbui", "packer", "minimap", "Outline", "toggleterm" }

local function is_dashboard()
	local buftype = buffer.get_buffer_filetype()
	if buftype == "DASHBOARD" then
		return true
	end
end

local function is_not_dashboard()
	local buftype = buffer.get_buffer_filetype()
	if buftype ~= "DASHBOARD" then
		return true
	end
end

gls.left[1] = {
	RainbowRed = {
		provider = function()
			return "▊ "
		end,
		highlight = { colors.blue, colors.bg },
	},
}
gls.left[2] = {
	ViMode = {
		provider = function()
			-- auto change color according the vim mode
			local mode_color = {
				n = colors.red,
				i = colors.green,
				v = colors.blue,
				[""] = colors.blue,
				V = colors.blue,
				c = colors.magenta,
				no = colors.red,
				s = colors.orange,
				S = colors.orange,
				[""] = colors.orange,
				ic = colors.yellow,
				R = colors.magenta,
				Rv = colors.magenta,
				cv = colors.red,
				ce = colors.red,
				r = colors.cyan,
				rm = colors.cyan,
				["r?"] = colors.cyan,
				["!"] = colors.red,
				t = colors.red,
			}
			vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
			return "  "
		end,
		highlight = { colors.red, colors.bg, "bold" },
	},
}
-- gls.left[3] = {
--   FileSize = {
--     provider = "FileSize",
--     condition = condition.buffer_not_empty,
--     highlight = { colors.fg, colors.bg },
--     separator = " ",
--     separator_highlight = { colors.bg, colors.bg },
--   },
-- }

gls.left[4] = {
	FileIcon = {
		provider = "FileIcon",
		condition = condition.buffer_not_empty,
		highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg },
	},
}

gls.left[5] = {
	FileName = {
		provider = "FileName",
		condition = condition.buffer_not_empty,
		highlight = { colors.fg, colors.bg, "bold" },
		separator = " ",
		separator_highlight = { colors.bg, colors.bg },
	},
}
gls.left[6] = {
	LineInfo = {
		provider = function()
			local line = vim.fn.line(".")
			local column = vim.fn.col(".")
			return string.format("%3d : %2d  ", line, column)
		end,
		-- condition = is_not_dashboard,
		highlight = { colors.fg_alt, colors.bg },

		-- provider = "LineColumn",
		-- separator = " ",
		-- separator_highlight = { "NONE", colors.bg },
		-- highlight = { colors.fg, colors.bg },
	},
}

gls.left[7] = {
	LinePercent = {
		provider = "LinePercent",
		highlight = { colors.fg_alt, colors.bg },
		separator = " ",
		separator_highlight = { colors.bg, colors.bg },
	},
}

gls.left[8] = {
	DiagnosticError = {
		provider = "DiagnosticError",
		icon = "  ",
		highlight = { colors.red, colors.bg },
	},
}

gls.left[9] = {
	DiagnosticWarn = {
		provider = "DiagnosticWarn",
		icon = "  ",
		highlight = { colors.red, colors.bg },
	},
}

gls.left[10] = {
	DiagnosticInfo = {
		provider = "DiagnosticInfo",
		icon = "  ",
		highlight = { colors.blue, colors.bg },
	},
}

-- Right side
-- alternate separator colors if the current buffer is a dashboard

gls.right[1] = {
	FileFormat = {
		provider = "FileFormat",
		condition = condition.hide_in_width,
		highlight = { colors.fg, colors.bg },
		separator = " ",
		separator_highlight = { colors.bg, colors.bg },
	},
}
gls.right[2] = {
	FileEncode = {
		provider = "FileEncode",
		condition = condition.hide_in_width,
		highlight = { colors.fg, colors.bg },
		separator = " ",
		separator_highlight = { colors.bg, colors.bg },
	},
}
local get_lsp_client = function(msg)
	msg = msg or "LSP Inactive"
	local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
	local clients = vim.lsp.get_active_clients()
	if next(clients) == nil then
		-- TODO idk why we need msg
		-- return msg
		return " " .. (vim.bo.filetype:gsub("^%l", string.upper))
	end
	local lsps = ""
	for _, client in ipairs(clients) do
		if client.name ~= "null-ls" then
			local filetypes = client.config.filetypes
			if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
				-- print(client.name)
				if lsps == "" then
					-- print("first", lsps)
					lsps = client.name
				else
					if not string.find(lsps, client.name) then
						lsps = lsps .. ", " .. client.name
					end
					-- print("more", lsps)
				end
			end
		end
	end
	if lsps == "" then
		return " " .. (vim.bo.filetype:gsub("^%l", string.upper))
		-- return msg
	else
		return " " .. lsps
	end
end

-- local lsps = ""
-- for _, client in ipairs(vim.lsp.buf_get_clients()) do
--   lsps = lsps .. ", " .. client.name
-- end

gls.right[3] = {
	ShowLspClientOrFileType = {
		provider = get_lsp_client,
		-- provider = function()
		--   -- Check if there's a LSP client running to avoid redundant
		--   -- statusline elements
		--   if lsp.get_lsp_client() ~= "No Active Lsp" then
		--     return " " .. lsp.get_lsp_client():gsub("^%l", string.upper)
		--   else
		--     -- Use the filetype instead and capitalize it
		--     return " " .. (vim.bo.filetype:gsub("^%l", string.upper))
		--   end
		-- end,
		condition = function()
			local tbl = { ["dashboard"] = true, [""] = true }
			if tbl[bo.filetype] then
				return false
			end
			return true
		end,
		highlight = { colors.blue, colors.bg },
		separator = "  ",
		separator_highlight = { colors.bg, colors.bg },
	},
}

gls.right[4] = {
	GitIcon = {
		provider = function()
			return "  "
		end,
		condition = condition.check_git_workspace,
		highlight = { colors.red, colors.bg },
		separator = " ",
		separator_highlight = { colors.bg, colors.bg },
	},
}

gls.right[5] = {
	GitBranch = {
		provider = "GitBranch",
		condition = condition.check_git_workspace,
		highlight = { colors.green, colors.bg },
	},
}
gls.right[6] = {
	DiffSeparator = {
		provider = function()
			return "   "
		end,
		condition = is_not_dashboard,
		highlight = { colors.bg, colors.bg },
	},
}

gls.right[7] = {
	DiffAdd = {
		provider = "DiffAdd",
		condition = condition.hide_in_width,
		icon = " ",
		highlight = { colors.green, colors.bg },
	},
}
gls.right[8] = {
	DiffModified = {
		provider = "DiffModified",
		condition = condition.hide_in_width,
		icon = " ",
		highlight = { colors.orange, colors.bg },
	},
}
gls.right[9] = {
	DiffRemove = {
		provider = "DiffRemove",
		condition = condition.hide_in_width,
		icon = " ",
		highlight = { colors.red, colors.bg },
	},
}

-- gls.right[10] = {
--   RainbowBlue = {
--     provider = function()
--       return " ▊"
--     end,
--     highlight = { colors.blue, colors.bg },
--   },
-- }

-- Short status line
gls.short_line_left[1] = {
	shortrainbowleft = {
		provider = function()
			return "▊ "
		end,
		highlight = { colors.blue, colors.bg },
	},
}

gls.short_line_left[2] = {
	BufferType = {
		provider = "FileTypeName",
		highlight = { colors.fg, colors.bg },
		-- separator = " ",
		-- separator_highlight = { "NONE", colors.bg },
		-- highlight = { colors.blue, colors.bg, "bold" },
	},
}

-- gls.short_line_left[2] = {
--   SFileName = {
--     provider = "SFileName",
--     condition = condition.buffer_not_empty,
--     highlight = { colors.fg, colors.bg, "bold" },
--   },
-- }

gls.short_line_right[1] = {
	BufferIcon = {
		provider = "BufferIcon",
		highlight = { colors.yellow, colors.bg },
	},
}

-- gls.short_line_right[2] = {
--   ShortRainbowRight = {
--     provider = function()
--       return " ▊"
--     end,
--     highlight = { colors.blue, colors.bg },
--   },
-- }

--   local function is_dashboard()
--     local buftype = buffer.get_buffer_filetype()
--     if buftype == "DASHBOARD" then
--       return true
--     end
--   end
--
--   local function is_not_dashboard()
--     local buftype = buffer.get_buffer_filetype()
--     if buftype ~= "DASHBOARD" then
--       return true
--     end
--   end
