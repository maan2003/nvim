local use = require('packer').use
-- themes
use 'wittyjudge/gruvbox-material.nvim'
require('gruvbox-material').setup()
use 'arkav/lualine-lsp-progress'

vim.o.termguicolors = true

use 'projekt0n/circles.nvim'

use {
   'projekt0n/github-nvim-theme',
   disable = true,
}

vim.cmd [[hi link LuasnipInsertNodeActive InfoFloat]]
vim.cmd [[hi link LuasnipInsertNodePassive Visual]]

-- lua line
use {
   'hoob3rt/lualine.nvim',
   requires = { 'kyazdani42/nvim-web-devicons' },
   config = function()
      require('lualine').setup {
         options = {
            disabled_filetypes = { 'toggleterm', 'Trouble' },
            section_separators = '',
            component_separtors = '',
            icons_enabled = false,
            globalstatus = true,
         },
         sections = {
            lualine_b = {},
            lualine_c = {
               {
                  'filename',
                  file_status = true, -- Displays file status (readonly status, modified status)
                  path = 1, -- relative path
                  shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                  -- for other components. (terrible name, any suggestions?)
                  symbols = {
                     modified = '[+]', -- Text to show when the file is modified.
                     readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
                     unnamed = '[No Name]', -- Text to show for unnamed buffers.
                  },
               },
               'lsp_progress',
            },
            lualine_x = {},
         },
      }
   end,
}
