local M = {}

M.config = function()
  vim.opt.timeoutlen = 200
  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
  vim.wo.foldlevel = 4
  vim.wo.foldtext =
    [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
  vim.wo.foldnestmax = 3
  vim.wo.foldminlines = 1
  vim.opt.fillchars = "fold: "
  vim.opt.foldnestmax = 3
  vim.opt.foldminlines = 1
  vim.opt.showtabline = 0
  vim.opt.relativenumber = true
  -- vim.opt.guifont = "JetBrainsMono Nerd Font:h14"
  vim.opt.pumblend = 10 -- Popup blend auto_open
  -- vim.opt.wrap = true
  vim.opt.wrapscan = true -- Searches wrap around the end of the file
  vim.opt.cmdheight = 2

  -- TODO: make incsearch look better with wilder.nvim
  vim.opt.incsearch = true

  vim.opt.list = true
  -- vim.opt.confirm = true -- make vim prompt me to save before doing destructive things
  vim.opt.autowriteall = true -- automatically :write before running commands and changing files
  vim.opt.clipboard = { "unnamedplus" }
  vim.opt.fillchars = {
    vert = "▕", -- alternatives │
    fold = " ",
    eob = " ", -- suppress ~ at EndOfBuffer
    diff = "╱", -- alternatives = ⣿ ░ ─
    msgsep = "‾",
    foldopen = "▾",
    foldsep = "│",
    foldclose = "▸",
  }
  vim.opt.wildignore = {
    "*.aux,*.out,*.toc",
    "*.o,*.obj,*.dll,*.jar,*.pyc,__pycache__,*.rbc,*.class",
    -- media
    "*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp",
    "*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm",
    "*.eot,*.otf,*.ttf,*.woff",
    "*.doc,*.pdf",
    -- archives
    "*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz",
    -- temp/system
    "*.*~,*~ ",
    "*.swp,.lock,.DS_Store,._*,tags.lock",
    -- version control
    ".git,.svn",
  }
  -- vim.opt.shortmess = {
  --   t = true, -- truncate file messages at start
  --   A = true, -- ignore annoying swap file messages
  --   o = true, -- file-read message overwrites previous
  --   O = true, -- file-read message overwrites previous
  --   T = true, -- truncate non-file messages in middle
  --   f = true, -- (file x of x) instead of just (x of x
  --   -- F = true, -- Don't give file info when editing a file, NOTE: this breaks autocommand messages
  --   s = true,
  --   c = true,
  --   W = true, -- Don't show [w] or written when writing
  -- }
  vim.opt.formatoptions = {
    ["1"] = true,
    ["2"] = true, -- Use indent from 2nd line of a paragraph
    q = true, -- continue comments with gq"
    c = true, -- Auto-wrap comments using textwidth
    r = true, -- Continue comments when pressing Enter
    n = true, -- Recognize numbered lists
    t = false, -- autowrap lines using text width value
    j = true, -- remove a comment leader when joining lines.
    -- Only break if the line was not longer than 'textwidth' when the insert
    -- started and only at a white character that has been entered during the
    -- current insert command.
    l = true,
    v = true,
  }
  vim.opt.listchars = {
    eol = nil,
    -- eol = "",
    tab = "  ", -- less laggy version of indent line
    -- tab = "│ ", -- less laggy version of indent line
    extends = "›", -- Alternatives: … »
    precedes = "‹", -- Alternatives: … «
    trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2)
  }
end

return M
