local use = require('packer').use
-- themes
use 'yonlu/omni.vim'
use 'elianiva/icy.nvim'
use 'sainnhe/gruvbox-material'
use 'arkav/lualine-lsp-progress'

-- vim.cmd[[let g:gruvbox_material_diagnostic_virtual_text = 'colored']]
-- vim.cmd[[colorscheme gruvbox-material]]
-- icons for lsp
use {
   'projekt0n/circles.nvim',
   config = function()
   end,
}


use {
   'projekt0n/github-nvim-theme',
   config = function()
      require('github-theme').setup { theme_style = 'dark' }
   end,
}

-- lua line
use {
   'hoob3rt/lualine.nvim',
   requires = { 'kyazdani42/nvim-web-devicons' },
   config = function()
      require('lualine').setup {
         options = {
            theme = 'github',
            disabled_filetypes = { 'toggleterm', 'Trouble' },
            section_separators = '',
            component_separtors = '',
            icons = false,
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
