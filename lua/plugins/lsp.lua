local use = require('packer').use

use {
   'neovim/nvim-lspconfig',
   config = function()
      local cfg = require 'lspconfig'
      cfg.clangd.setup {}
      cfg.zls.setup {}
   end,
}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
   virtual_text = true,
   signs = false,
   underline = true,
   update_in_insert = false,
   severity_sort = true,
})

use {
   'simrat39/rust-tools.nvim',
   config = function()
      local caps = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      require('rust-tools').setup {
         tools = {
            autoSetHints = false,
         },
         server = {
            capabilities = caps,
            settings = {
               ['rust-analyzer'] = {
                  checkOnSave = {
                     command = 'clippy',
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
   requires = 'kyazdani42/nvim-web-devicons',
}

-- doesn't work :no_mouth:
use {
   'windwp/lsp-fastaction.nvim',
   config = function()
      require('lsp-fastaction').setup {
         hide_cursor = true,
         action_data = {
            --- action for filetype dart
            ['dart'] = {
               -- pattern is a lua regex with lower case
               { pattern = 'import library', key = 'i', order = 1 },
               { pattern = 'wrap with widget', key = 'w', order = 2 },
               { pattern = 'wrap with column', key = 'c', order = 3 },
               { pattern = 'wrap with row', key = 'r', order = 3 },
               { pattern = 'wrap with sizedbox', key = 's', order = 3 },
               { pattern = 'wrap with container', key = 'C', order = 4 },
               { pattern = 'wrap with center', key = 'E', order = 4 },
               { pattern = 'padding', key = 'P', order = 4 },
               { pattern = 'wrap with streambuilder', key = 'S', order = 5 },
               { pattern = 'remove', key = 'R', order = 5 },

               --range code action
               { pattern = "surround with %'if'", key = 'i', order = 2 },
               { pattern = 'try%-catch', key = 't', order = 2 },
               { pattern = 'for%-in', key = 'f', order = 2 },
               { pattern = 'setstate', key = 's', order = 2 },
            },
            ['typescript'] = {
               { pattern = 'to existing import declaration', key = 'a', order = 2 },
               { pattern = 'from module', key = 'i', order = 1 },
            },
         },
      }
   end,
}

use {
    'williamboman/nvim-lsp-installer',
}
local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
    local opts = {}

    -- (optional) Customize the options passed to the server
    -- if server.name == "tsserver" then
    --     opts.root_dir = function() ... end
    -- end

    -- This setup() function is exactly the same as lspconfig's setup function.
    -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    server:setup(opts)
end)

use 'theHamsta/nvim-semantic-tokens'
  require("nvim-semantic-tokens").setup {
    preset = "default"
  }
