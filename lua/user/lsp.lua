local M = {}

M.config = function()
  lvim.lsp.diagnostics.virtual_text = false
  lvim.lsp.document_highlight = true

  -- local capabilities = require("lvim.lsp").common_capabilities()
  -- capabilities.offsetEncoding = { "utf-16" }
  -- require("lspconfig").clangd.setup { capabilities = capabilities }

  -- set a formatter, this will override the language server formatting capabilities (if it exists)
  local formatters = require "lvim.lsp.null-ls.formatters"
  formatters.setup {
    { command = "gofumpt", filetypes = { "go" } },
    { command = "golines", filetypes = { "go" } },
    { command = "stylua", filetypes = { "lua" } },
    { command = "black", filetypes = { "python" } },
    { command = "isort", filetypes = { "python" } },
    { command = "shfmt", filetypes = { "sh" } },
    { command = "shellharden", filetypes = { "sh" } },
    -- { command = "clang_format", filetypes = { "cpp", "c" } },
    { command = "uncrustify", filetypes = { "cpp", "c" } },
    {
      -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
      command = "prettier",
      ---@usage arguments to pass to the formatter
      -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
      extra_args = { "--print-with", "100" },
      ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
      filetypes = { "typescript", "typescriptreact", "markdown" },
    },
  }

  -- set additional linters
  local linters = require "lvim.lsp.null-ls.linters"
  linters.setup {
    -- { command = "flake8", filetypes = { "python" } },
    -- { command = "mypy", filetypes = { "python" }, extra_args = { "--strict" } },
    { command = "pylint", filetypes = { "python" } },
    { command = "vint", filetypes = { "vim" } },
    { command = "cppcheck", filetypes = { "cpp", "c" } },
    -- { command = "golangci_lint", filetypes = { "go" } },
    { command = "markdownlint", filetypes = { "markdown" }, extra_args = { "--disable", "MD013", "MD010" } },
    {
      -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
      command = "shellcheck",
      ---@usage arguments to pass to the formatter
      -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
      extra_args = { "--severity", "warning" },
    },
    { command = "luacheck", filetypes = { "lua" } },
    -- {
    --   command = "codespell",
    --   ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    --   filetypes = { "javascript", "python" },
    -- },
  }

  require("user.keymaps").set_lsp_buf_keymaps()

  -- if you don't want all the parsers change this to a table of the ones you want
  -- generic LSP settings

  -- ---@usage disable automatic installation of servers
  -- lvim.lsp.automatic_servers_installation = false

  ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
  ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
  -- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
  -- local opts = {} -- check the lspconfig documentation for a list of all possible options
  -- require("lvim.lsp.manager").setup("pyright", opts)

  -- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
  -- ---`:LvimInfo` lists which server(s) are skiipped for the current filetype
  -- vim.tbl_map(function(server)
  --   return server ~= "emmet_ls"
  -- end, lvim.lsp.automatic_configuration.skipped_servers)

  -- you can set a custom on_attach function that will be used for all the language servers
  -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
  lvim.lsp.on_attach_callback = function(client, bufnr)
    local function add_lsp_buffer_keybindings(bufnr)
      local mappings = {
        normal_mode = "n",
        insert_mode = "i",
        visual_mode = "v",
      }

      if lvim.builtin.which_key.active then
        -- Remap using which_key
        local status_ok, wk = pcall(require, "which-key")
        if not status_ok then
          return
        end
        for mode_name, mode_char in pairs(mappings) do
          wk.register(lvim.lsp.buffer_mappings[mode_name], { mode = mode_char, buffer = bufnr })
        end
      else
        -- Remap using nvim api
        for mode_name, mode_char in pairs(mappings) do
          for key, remap in pairs(lvim.lsp.buffer_mappings[mode_name]) do
            vim.api.nvim_buf_set_keymap(bufnr, mode_char, key, remap[1], { noremap = true, silent = true })
          end
        end
      end
    end

    local lu = require "lvim.lsp.utils"
    if lvim.lsp.document_highlight then
      lu.setup_document_highlight(client, bufnr)
    end
    if lvim.lsp.code_lens_refresh then
      lu.setup_codelens_refresh(client, bufnr)
    end
    add_lsp_buffer_keybindings(bufnr)

    if client["name"] ~= "null-ls" then
      local navic = require "nvim-navic"
      navic.attach(client, bufnr)
    end

    -- local function buf_set_option(...)
    --   vim.api.nvim_buf_set_option(bufnr, ...)
    -- end

    -- --Enable completion triggered by <c-x><c-o>
    -- buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
  end
end

return M
