local use = require('packer').use
-- themes
use 'wittyjudge/gruvbox-material.nvim'
use 'arkav/lualine-lsp-progress'

vim.o.termguicolors = true
require('gruvbox-material').setup()

use 'projekt0n/circles.nvim'


use {
   'projekt0n/github-nvim-theme',
   config = function()
      -- require('github-theme').setup { theme_style = 'dark' }
      -- vim.cmd[[hi Normal guibg=NONE ctermbg=NONE]]
   end,
}

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
            icons = false,
            globalstatus = true,
         },
         sections = {
            lualine_b = {
               'lsp_progress',
            },
         },
         -- TODO: fix this
      }
   end,
}
