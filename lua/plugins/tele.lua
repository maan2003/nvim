local use = require('packer').use

use {
   'nvim-telescope/telescope.nvim',
   opt = true,
   cmd = 'Telescope',

   config = function()
      require('telescope').setup {
         defaults = {
            mappings = {
                i = {
                    ['<f9>'] =  require "telescope.actions".close,
                },
            },
            layout_config = {
               horizontal = {
                  width = 999,
                  height = 999,
                  preview_width = 0.60,
               },
            },
         },
         extensions = {
            fzf = {
               fuzzy = true, -- false will only do exact matching
               override_generic_sorter = true, -- override the generic sorter
               override_file_sorter = true, -- override the file sorter
               case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
               -- the default case_mode is "smart_case"
            },
            fzy_native = {
               override_generic_sorter = true,
               override_file_sorter = true,
            },
            frecency = {
                ignore_patterns = {
                '*.git/*',
                '*/tmp/*',
                '/usr/*',
                '*/.rustup/*',
                '/share/*',
                '/usr/*',
                '*/.cargo/registry/*',
                },
            },
         },
      }
   end,
}

use {
   'nvim-telescope/telescope-fzf-native.nvim',
   after = 'telescope.nvim',
   run = 'make',
   config = function()
      require('telescope').load_extension 'fzf'
   end,
}

use {
   'nvim-telescope/telescope-frecency.nvim',
   after = 'telescope.nvim',
   requires = { 'tami5/sqlite.lua' },
   config = function()
      require('telescope').load_extension 'frecency'
   end,
}

use {
    'stevearc/dressing.nvim',
    config = function()
        require('dressing').setup({
            input = {
                enabled = true,
                winblend = 0,
            },
            select = {
                enabled = true,
                telescope = require('telescope.themes').get_cursor()
            },
        })
    end
}
