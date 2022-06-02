local use = require('packer').use

use {
   'neovim/nvim-lspconfig',
   config = function()
      local cfg = require 'lspconfig'
      cfg.clangd.setup { }
      cfg.zls.setup {}
   end,
}

use {
   'simrat39/rust-tools.nvim',
   config = function()
      local caps = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      require('rust-tools').setup {
         tools = {
            autoSetHints = false,
         },
         server = {
            cmd = { "nc", "localhost", "6969" },
            root_dir = function(fname) 
               local util = require 'lspconfig.util'
               return util.root_pattern 'Cargo.lock'(fname)
                   or util.root_pattern 'Cargo.toml'(fname)
                   or util.root_pattern 'rust-project.json'(fname)
                   or util.find_git_ancestor(fname)
            end,
            capabilities = caps,
            standalone = false,
            settings = {
               ['rust-analyzer'] = {
                  checkOnSave = {
                     command = 'check',
                  },
                  cargo = {
                     runBuildScript = true,
                  },
               },
            },
         },
      }
   end,
}

use {
   'folke/trouble.nvim',
   disable = true,
   requires = 'kyazdani42/nvim-web-devicons',
}

use {
   'williamboman/nvim-lsp-installer',
   config = function() 
      local lsp_installer = require("nvim-lsp-installer")

      lsp_installer.on_server_ready(function(server)
         local opts = {}
         server:setup(opts)
      end)
   end
}


