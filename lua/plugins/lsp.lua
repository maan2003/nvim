local use = require('packer').use

use {
   'williamboman/mason.nvim',
   config = function() 
      require("mason").setup()
   end,
}

use {
   'williamboman/mason-lspconfig.nvim',
   config = function()
      require('mason-lspconfig').setup {
         automatic_installation = true,
      }
   end,
}

use {
   "folke/neodev.nvim",
   config = function ()
   end
}

use {
   'neovim/nvim-lspconfig',
   config = function()
      require("neodev").setup{ }
      local cfg = require 'lspconfig'
      cfg.clangd.setup {}
      cfg.zls.setup {}
      cfg.tsserver.setup {
         single_file_support = false,
      }
      cfg.pyright.setup{}
      cfg.sumneko_lua.setup {}
      cfg.denols.setup {}
      cfg.svelte.setup {}
   end,
}

use {
   'simrat39/rust-tools.nvim',
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
               return util.root_pattern 'Cargo.lock'(fname)
                  or util.root_pattern 'Cargo.toml'(fname)
                  or util.root_pattern 'rust-project.json'(fname)
                  or util.find_git_ancestor(fname)
            end,
            capabilities = caps,
            standalone = false,
         },
      }
   end,
}

use {
   'folke/trouble.nvim',
   disable = true,
   requires = 'kyazdani42/nvim-web-devicons',
}

vim.diagnostic.config { signs = false }
use {
   '~/src/lsp_lines.nvim',
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
}

