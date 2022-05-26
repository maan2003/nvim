local use = require('packer').use


use {
   'ahmedkhalf/project.nvim',
   config = function()
      require('project_nvim').setup {
         manual_mode = false,
         exclude_dirs = { '~/.cargo/*', '~/.rustup/*', '~/.local/*', '/usr/*' },
      }
      require('telescope').load_extension 'projects'
   end,
}

use {
   'windwp/nvim-autopairs',
   config = function()
      require('nvim-autopairs').setup()
   end,
}

use {
   'phaazon/hop.nvim',
   opt = true,
   cmd = { 'HopChar1' },
   config = function()
      require('hop').setup { keys = 'arstdhneiofuvkpl' }
   end,
}
use 'sbdchd/neoformat'
use {
   'akinsho/toggleterm.nvim',
   config = function()
      require('toggleterm').setup {
         -- size can be a number or function which is passed the current terminal
         size = 15,
         open_mapping = '<c-\\>',
         hide_numbers = true, -- hide the number column in toggleterm buffers
         shade_filetypes = {},
         shade_terminals = true,
         shading_factor = '1', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
         start_in_insert = true,
         insert_mappings = true, -- whether or not the open mapping applies in insert mode
         persist_size = true,
         direction = 'float',
         close_on_exit = true, -- close the terminal window when the process exits
      }
   end,
}

use {
   'LionC/nest.nvim',
   config = function()
      require('nest').applyKeymaps(require 'mxkeymap')
   end,
}

-- copilot lets go
-- fuck you copilot
use 'github/copilot.vim'

use {
   'TimUntersberger/neogit',
   requires = {
      'sindrets/diffview.nvim',
   },
   config = function()
      require('neogit').setup {
         signs = {
            section = { '▸', '▾' },
            item = {
               '▸',
               '▾',
            },
            hunk = { '', '' },
         },
         disable_hint = true,
         integrations = {
            diffview = true,
         },
      }
   end,
}

use 'kevinhwang91/nvim-bqf'

use {
   'chipsenkbeil/distant.nvim',
   config = function()
      require('distant').setup {
         -- Applies Chip's personal settings to every machine you connect to
         --
         -- 1. Ensures that distant servers terminate with no connections
         -- 2. Provides navigation bindings for remote directories
         -- 3. Provides keybinding to jump into a remote file's parent directory
         ['*'] = require('distant.settings').chip_default(),
      }
   end,
}

use {
    'sakhnik/nvim-gdb',
    run = "./install.sh",
}

vim.cmd[[autocmd BufEnter term://* startinsert]]
vim.cmd[[tnoremap <F9><F9> <C-\><C-n><C-w><C-w>]]
vim.cmd[[noremap <F9><F9> <C-w><C-w>]]
vim.cmd[[autocmd TermOpen * setlocal nobuflisted nonumber norelativenumber]]

local function gdb()
    return NvimGdb.i()
end

local function gdbsend(arg) 
    return function() gdb():send(arg) end
end

local dbg_mappings = {
    {'n', gdbsend("next")},
    {'s', gdbsend("step")},
    {'N', gdbsend('reverse-next')},
    {'f', gdbsend('finish')},
    {'F', gdbsend('reverse-finish')},
    {'u', function () 
        gdb():send('until "%s:%s"', vim.fn.expand("%:p"), vim.fn.line('.')) 
    end},
    {'c', gdbsend('continue')},
    {'C', gdbsend('reverse-continue')},
    -- TODO: treesitter expr
    {'p', '<cmd>GdbEvalWord<cr>'},
    {'a', function () 
        gdb():send('advance "%s:%s"', vim.fn.expand("%:p"), vim.fn.line('.')) 
    end},
    {'d', function() gdb():breakpoint_toggle() end},
    {'<C-u>', gdbsend('up') },
    {'<C-d>', gdbsend('down') },
}

require('nvimgdb.config').setup {
    set_keymaps = function() 

        require 'nest'.applyKeymaps {
            buffer = true,
            options = { nowait = true, noremap = true },
            dbg_mappings,
        }
    end,
    unset_keymaps = function()
        for key in pairs(dbg_mappings) do
            vim.api.nvim_buf_del_keymap(0, 'n', key[0])
        end
    end
}

use {
  "ahmedkhalf/jupyter-nvim",
  run = ":UpdateRemotePlugins",
  config = function()
    require("jupyter-nvim").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
}

vim.cmd[[hi GdbCurrentLine guibg=#464022]]
vim.cmd[[hi GdbBreakpointSign guifg=#EA6962]]
