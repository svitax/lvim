local opts = {
  on_attach = function(client, bufnr)
    local status_ok, ts_utils = pcall(require, "nvim-lsp-ts-utils")
    if not status_ok then
      vim.cmd [[ packadd jose-elias-alvarez/nvim-lsp-ts-utils ]]
      ts_utils = require "nvim-lsp-ts-utils"
    end
    -- defaults
    ts_utils.setup {
      debug = false,
      disable_commands = false,
      enable_import_on_completion = true,

      -- import all
      import_all_timeout = 5000, -- ms
      -- lower numbers indicate higher priority
      import_all_priorities = {
        same_file = 1, -- add to existing import statement
        local_files = 2, -- git files or files with relative path markers
        buffer_content = 3, -- loaded buffer content
        buffers = 4, -- loaded buffer names
      },
      import_all_scan_buffers = 100,
      import_all_select_source = false,

      -- eslint
      eslint_enable_code_actions = true,
      eslint_enable_disable_comments = true,
      eslint_bin = "eslint_d",
      eslint_config_fallback = nil,
      eslint_enable_diagnostics = false,

      -- formatting
      enable_formatting = false,
      formatter = "prettierd",
      formatter_config_fallback = nil,

      -- parentheses completion
      complete_parens = false,
      signature_help_in_parens = false,

      -- update imports on file move
      update_imports_on_move = false,
      require_confirmation_on_move = false,
      watch_dir = nil,

      -- filter diagnostics
      filter_out_diagnostics_by_code = {},
      filter_out_diagnostics_by_severity = {},
    }

    ts_utils.setup_client(client)
    require("lvim.lsp").common_on_attach(client, bufnr)

    local wk = require "which-key"
    -- better keybindings for ts and tsx files
    local langs = { "javascript", "javascriptreact", "typescript", "typescriptreact" }
    local ftype = vim.bo.filetype
    if vim.tbl_contains(langs, ftype) then
      local ts_keys = {
        ["<leader>lm"] = { "<cmd>TSLspImportAll<CR>", "import all" },
        ["<leader>ln"] = { "<cmd>TSLspRenameFile<CR>", "rename file" },
        ["<leader>lg"] = { "<cmd>TSLspOrganize<CR>", "organize imports" },
        ["gA"] = { "<cmd>TSLspImportAll<CR>", "import all" },
        ["gr"] = { "<cmd>TSLspRenameFile<CR>", "rename file" },
        ["gS"] = { "<cmd>TSLspOrganize<CR>", "organize imports" },
        -- []
      }
      wk.register(ts_keys, { mode = "n" })
    end
  end,
}

return opts
