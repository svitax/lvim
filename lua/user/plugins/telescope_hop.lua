local M = {}

M.config = function()
  lvim.builtin.telescope.extensions.hop = {
    -- the shown `keys` are the defaults, no need to set `keys` if defaults work for you ;)
    keys = { "a", "s", "d", "f", "g", "h", "l", "q", "w", "e", "r", "t", "y", "u", "i", "o", "p" },
    -- Highlight groups to link to signs and lines; the below configuration refers to demo
    -- sign_hl typically only defines foreground to possibly be combined with line_hl
    sign_hl = { "WarningMsg", "Title" },
    -- optional, typically a table of two highlight groups that are alternated between
    line_hl = { "CursorLine", "Normal" },
    -- options specific to `hop_loop`
    -- true temporarily disables Telescope selection highlighting
    clear_selection_hl = false,
    -- highlight hopped to entry with telescope selection highlight
    -- note: mutually exclusive with `clear_selection_hl`
    trace_entry = true,
    -- jump to entry where hoop loop was started from
    reset_selection = true,
  }
  require("telescope").load_extension "hop"
end

return M
