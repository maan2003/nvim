local use = require('packer').use

use {
   'ahmedkhalf/project.nvim',
   after = 'telescope.nvim',
   config = function()
      require('project_nvim').setup {
         manual_mode = false,
         detection_methods = { 'lsp' },
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
use {
   'sbdchd/neoformat',
   cmd = { 'Neoformat' },
}

use {
   'akinsho/toggleterm.nvim',
   opt = true,
   cmd = { 'ToggleTerm' },
   keys = { '<c-\\>' },

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
         direction = 'tab',
         close_on_exit = true, -- close the terminal window when the process exits
      }
   end,
}

function _G.terminal_run() 
  vim.cmd[[terminal run %]]
  vim.cmd[[startinsert]]
end
vim.cmd[[
nnoremap <Leader>rr <CMD>lua terminal_run()<CR>
]]

use {
   'LionC/nest.nvim',
   config = function()
      require('nest').applyKeymaps(require 'mxkeymap')
   end,
}

use 'tpope/vim-fugitive'
use {
   'TimUntersberger/neogit',
   opt = true,
   cmd = { 'Neogit' },
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

use {
   'ldelossa/gh.nvim',
   requires = { { 'ldelossa/litee.nvim' } },
   config = function()
      require('litee.lib').setup()
      require('litee.gh').setup {
         -- deprecated, around for compatability for now.
         jump_mode = 'invoking',
         -- remap the arrow keys to resize any litee.nvim windows.
         map_resize_keys = false,
         -- do not map any keys inside any gh.nvim buffers.
         disable_keymaps = false,
         -- the icon set to use.
         icon_set = 'default',
         -- any custom icons to use.
         icon_set_custom = nil,
         -- whether to register the @username and #issue_number omnifunc completion
         -- in buffers which start with .git/
         git_buffer_completion = true,
         -- defines keymaps in gh.nvim buffers.
         keymaps = {
            -- when inside a gh.nvim panel, this key will open a node if it has
            -- any futher functionality. for example, hitting <CR> on a commit node
            -- will open the commit's changed files in a new gh.nvim panel.
            open = '<CR>',
            -- when inside a gh.nvim panel, expand a collapsed node
            expand = 'zo',
            -- when inside a gh.nvim panel, collpased and expanded node
            collapse = 'zc',
            -- when cursor is over a "#1234" formatted issue or PR, open its details
            -- and comments in a new tab.
            goto_issue = 'gd',
            -- show any details about a node, typically, this reveals commit messages
            -- and submitted review bodys.
            details = 'd',
            -- inside a convo buffer, submit a comment
            submit_comment = '<C-s>',
            -- inside a convo buffer, when your cursor is ontop of a comment, open
            -- up a set of actions that can be performed.
            actions = '<C-a>',
            -- inside a thread convo buffer, resolve the thread.
            resolve_thread = '<C-r>',
            -- inside a gh.nvim panel, if possible, open the node's web URL in your
            -- browser. useful particularily for digging into external failed CI
            -- checks.
            goto_web = 'gx',
         },
      }
   end,
}

use {
   'chipsenkbeil/distant.nvim',
   disable = true,
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

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
   pattern = { 'term://*' },
   callback = function()
      vim.cmd [[startinsert]]
   end,
})

-- vim.cmd [[
-- autocmd BufEnter term://* silent! set laststatus=3 cmdheight=0
-- ]]
-- vim.cmd [[
-- autocmd TermOpen term://* silent! set  cmdheight=0
-- ]]
-- vim.cmd [[
-- autocmd BufLeave term://* silent! set laststatus=3 cmdheight=1
-- ]]

vim.cmd [[tnoremap <F9><F9> <C-\><C-n><C-w><C-w>]]
vim.cmd [[noremap <F9><F9> <C-w><C-w>]]
vim.cmd [[autocmd TermOpen * setlocal nobuflisted nonumber norelativenumber]]

use {
  'nmac427/guess-indent.nvim',
  config = function() require('guess-indent').setup {} end,
}

use {
   'jghauser/mkdir.nvim',
}

use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end 
}

vim.g.firenvim_config = {
  localSettings = {
    [ [[.*notion\.so.*]] ] = {
      priority = 9,
      takeover = 'never',
    },
    [ [[.*docs\.google\.com.*]] ] = {
      priority = 9,
      takeover = 'never',
    },
    [ [[.*discord\.com.*]] ] = {
      priority = 9,
      takeover = 'never',
    },
    [ [[.*whatsapp\.com.*]] ] = {
      priority = 9,
      takeover = 'never',
    },
    [ [[.*]] ] = {
      filename = '/home/manmeet/cp/web/{hostname%32}_{pathname%10}.{extension}',
      selector = 'textarea:not(.firenvim)',
    },
  },
}
use({
    "kylechui/nvim-surround",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
})

     
use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}

vim.cmd[[autocmd FileType * set formatoptions-=o]]

use {
	"chrisgrieser/nvim-various-textobjs",
	config = function () 
		require("various-textobjs").setup({ useDefaultKeymaps = true })
	end,
}

use {
   "nvim-neo-tree/neo-tree.nvim",
   branch = "v2.x",
   requires = { 
   "nvim-lua/plenary.nvim",
   "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
   "MunifTanjim/nui.nvim",
   }
}

