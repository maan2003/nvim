vim.o.termguicolors = true
vim.cmd [[hi link LuasnipInsertNodeActive Visual]]

vim.cmd [[colorscheme zenwritten]]
return {
   -- {
   --    "mcchrish/zenbones.nvim",
   --    dependencies = { "rktjmp/lush.nvim" },
   --    priority = 200,
   --    lazy = false,
   --    config = function()
   --       vim.cmd [[colorscheme zenwritten]]
   --    end
   -- },
   'kyazdani42/nvim-web-devicons',
   {
      'echasnovski/mini.statusline', version = false,
      config = function()
         require("mini.statusline").setup({
            content = {
               active = function()
                  local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
                  local git = MiniStatusline.section_git({ trunc_width = 75 })
                  local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
                  local filename = MiniStatusline.section_filename({ trunc_width = 140 })
                  return MiniStatusline.combine_groups({
                     { hl = "Visual", strings = { mode } },
                     "%<", -- Mark general truncate point
                     { hl = "MiniStatuslineFilename", strings = { filename } },
                     "%=", -- End left alignment
                     { hl = "MiniStatuslineDevinfo", strings = { git, diagnostics } },
                  })
               end,
               inactive = nil,
            },

            -- Whether to use icons by default
            use_icons = true,
            set_vim_settings = false,
         })
         vim.o.laststatus = 3
      end
   },
   {
      'hoob3rt/lualine.nvim',
      enabled = false,
      lazy = false,
      opts = {
         options = {
            -- theme = 'zenwritten',
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
   },
   {
      "rcarriga/nvim-notify",
      opts = {
         render = 'minimal',
         stages = 'static',
      }
   },
   {
      "folke/noice.nvim",
      config = function()
         require("noice").setup()
      end,
      dependencies = {
         -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
         "MunifTanjim/nui.nvim",
         "rcarriga/nvim-notify",
         "hrsh7th/nvim-cmp",
      }
   }
}
