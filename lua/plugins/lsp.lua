local use = require('packer').use

use {
   'neovim/nvim-lspconfig',
   config = function()
      local cfg = require 'lspconfig'
      cfg.clangd.setup { }
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
            cmd = { "nc", "localhost", "6969" },
            capabilities = caps,
            standalone = false,
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

use ({
    'onsails/diaglist.nvim',
    config = function()
        require("diaglist").init({
            -- optional settings
            -- below are defaults
            debug = false,

            -- increase for noisy servers
            debounce_ms = 150,
        })
    end
})

use({
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  config = function()
    -- require("lsp_lines").register_lsp_virtual_lines()
  end,
})
