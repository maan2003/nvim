local use = require('packer').use

use 'nvim-telescope/telescope.nvim'

use {
   'nvim-telescope/telescope-fzf-native.nvim',
   run = 'make',
}

use {
   'nvim-telescope/telescope-frecency.nvim',
   requires = { 'tami5/sqlite.lua' },
}

require('telescope').setup {
   defaults = {
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
require('telescope').load_extension 'frecency'
require('telescope').load_extension 'fzf'

