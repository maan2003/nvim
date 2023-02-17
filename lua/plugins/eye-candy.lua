local use = require('packer').use
-- themes
use 'wittyjudge/gruvbox-material.nvim'
use 'Shatur/neovim-ayu'
-- require('gruvbox-material').setup {}

vim.o.termguicolors = true

use 'projekt0n/circles.nvim'

use 'projekt0n/github-nvim-theme'
use 'sainnhe/everforest'

use {
   'j-hui/fidget.nvim',
   config = function()
      require('fidget').setup {}
   end
}
use {
    "mcchrish/zenbones.nvim",
    -- Optionally install Lush. Allows for more configuration or extending the colorscheme
    -- If you don't want to install lush, make sure to set g:zenbones_compat = 1
    -- In Vim, compat mode is turned on as Lush only works in Neovim.
    requires = "rktjmp/lush.nvim",
    config = function()
        vim.cmd[[colorscheme zenwritten]]
    end
}

vim.cmd [[hi link LuasnipInsertNodeActive Visual]]
-- no highlight for passive nodes
-- vim.cmd [[hi link LuasnipInsertNodePassive Visual]]

-- lua line
use {
   'hoob3rt/lualine.nvim',
   requires = { 'kyazdani42/nvim-web-devicons' },
   config = function()
      require('lualine').setup {
         options = {
            -- theme = 'zenwritten',
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
            },
            lualine_x = {},
         },
      }
   end,
}

-- Packer
-- use({
--   "folke/noice.nvim",
--   event = "VimEnter",
--   enabled = false,
--   config = function()
--     require("noice").setup()
--   end,
--   requires = {
--     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
--     "MunifTanjim/nui.nvim",
--     "rcarriga/nvim-notify",
--     "hrsh7th/nvim-cmp",
--     }
-- })
