local opts = {

  on_attach = function(client, bufnr)
    -- disable tsserver formatting if you plan on formatting via null-ls
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    local status_ok, ts_utils = pcall(require, "nvim-lsp-ts-utils")
    if not status_ok then
      vim.cmd [[ packadd jose-elias-alvarez/nvim-lsp-ts-utils ]]
      ts_utils = require "nvim-lsp-ts-utils"
    end

    -- defaults
    ts_utils.setup {
      debug = false,
      disable_commands = false,
      enable_import_on_completion = false,

      -- import all
      import_all_timeout = 5000, -- ms
      import_all_priorities = {
        buffers = 4, -- loaded buffer names
        buffer_content = 3, -- loaded buffer content
        local_files = 2, -- git files or files with relative path markers
        same_file = 1, -- add to existing import statement
      },
      import_all_scan_buffers = 100,
      import_all_select_source = false,

      -- eslint
      eslint_enable_code_actions = true,
      eslint_enable_disable_comments = true,
      eslint_bin = "eslint_d",
      eslint_config_fallback = nil,
      eslint_enable_diagnostics = false,
      eslint_opts = {},

      -- formatting
      enable_formatting = false,
      formatter = "prettierd",
      formatter_config_fallback = nil,
      -- formatter_opts = {},

      -- update imports on file move
      update_imports_on_move = false,
      require_confirmation_on_move = false,
      watch_dir = nil,

      -- filter diagnostics
      -- filter_out_diagnostics_by_severity = {},
      -- filter_out_diagnostics_by_code = {},
    }

    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)

    -- no default maps, so you may want to define some here
    require("lvim.lsp").common_on_attach(client, bufnr)
    local opts = { silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "go", ":TSLspOrganize<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gF", ":TSLspRenameFile<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gA", ":TSLspImportAll<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>lO", ":TSLspOrganize<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>lF", ":TSLspRenameFile<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>lA", ":TSLspImportAll<CR>", opts)
    -- TODO: might be better as an autocommand after <leader>lf?
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>lf", ":lua vim.lsp.buf.formatting()<cr>:TSLspOrganize<CR>", opts)
  end,
}

return opts
