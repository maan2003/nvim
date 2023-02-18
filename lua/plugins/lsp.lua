vim.diagnostic.config { signs = false }
return {
   {
      'williamboman/mason.nvim',
      opts = {},
      cmd = "Mason",
   },
   {
      'neovim/nvim-lspconfig',
      dependencies = {
         'folke/neodev.nvim',
         {
            'williamboman/mason-lspconfig.nvim',
            opts = { automatic_installation = true },
         },
      },
      keys = {
         { 'xx', vim.lsp.buf.code_action, mode = {'n', 'x'} },
         { 'xf', vim.lsp.buf.format },
         { 'xr', vim.lsp.buf.rename },
         { 'gd', vim.lsp.buf.definition },
         { 'gt', vim.lsp.buf.type_definition },
         { 'gi', '<cmd>Telescope lsp_implementations<cr>' },
         { 'gr', '<cmd>Telescope lsp_references<cr>' },
         { 'g<space>', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>' },
      },
      event = "BufEnter",
      config = function()
         require("neodev").setup {}
         local cfg = require 'lspconfig'
         cfg.clangd.setup {}
         cfg.zls.setup {}
         cfg.tsserver.setup {
            single_file_support = false,
         }
         cfg.pyright.setup {}
         cfg.lua_ls.setup {}
         cfg.denols.setup {}
         cfg.svelte.setup {}
      end,
   },
   {
      'simrat39/rust-tools.nvim',
      event = "BufReadPre *.rs",
      keys = {
         {'gu', function() require('rust-tools').parent_module.parent_module() end }
      },
      config = function()
         local caps = require('cmp_nvim_lsp').default_capabilities()
         require('rust-tools').setup {
            tools = {
               inlay_hints = {
                  auto = false,
               },
            },
            server = {
               cmd = { 'nc', 'localhost', '6969' },
               root_dir = function(fname)
                  local util = require 'lspconfig.util'
                  return util.root_pattern 'Cargo.lock' (fname)
                      or util.root_pattern 'Cargo.toml' (fname)
                      or util.root_pattern 'rust-project.json' (fname)
                      or util.find_git_ancestor(fname)
               end,
               capabilities = caps,
               standalone = false,
            },
         }
      end,
   },
   {
      dir = '~/src/lsp_lines.nvim',
      event = "LspAttach",
      config = function()
         require('lsp_lines').setup()
         local min_warn = { min = vim.diagnostic.severity.WARN }
         vim.diagnostic.config {
            virtual_text = {
               severity = min_warn,
               prefix = '',
               format = function(diag)
                  if diag.message:match 'Unused' then
                     return ""
                  else
                     return diag.message
                  end
               end,
            },
            underline = {
               severity = min_warn,
            },
            virtual_lines = false,
         }
      end,
   },
}
