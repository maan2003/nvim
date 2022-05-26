local use = require('packer').use

use {
   'nvim-treesitter/nvim-treesitter',
   run = ':TSUpdate',
   config = function()
      require('nvim-treesitter.configs').setup {
         highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
         },
         indent = {
            enable = true,
         },
      }
   end,
}

use {
   'nvim-treesitter/playground',
   opt = true,
   cmd = 'TSPlaygroundToggle',
}

use {
   'romgrk/nvim-treesitter-context',
   config = function()
      require('treesitter-context').setup {
         patterns = {
            default = {
               'class',
               'function',
               'method',
               'for',
               'while',
               'if',
               'switch',
               'case',
            },
            rust = {
               'impl_item',
               'let_declaration',
            },
         },
      }
   end,
}

use {
   'nvim-treesitter/nvim-treesitter-textobjects',
   -- really ununsable right now
   disable = true,
   config = function()
      require('nvim-treesitter.configs').setup {
         textobjects = {
            select = {
               enable = true,

               -- Automatically jump forward to textobj, similar to targets.vim
               lookahead = true,

               keymaps = {
                  -- You can use the capture groups defined in textobjects.scm
                  ['f'] = '@function.outer',
                  ['t'] = '@statement.outer',
                  ['s'] = '@block.outer',
                  -- ['T'] = '@path',
                  -- ['p'] = '@item',
                  ['r'] = {
                     rust = '(_expression) @expr',
                  },
               },
            },
         },
      }
   end,
}
