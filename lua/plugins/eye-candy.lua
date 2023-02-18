vim.o.termguicolors = true
vim.cmd [[hi link LuasnipInsertNodeActive Visual]]

vim.cmd [[colorscheme zenwritten]]
vim.cmd [[hi DiagnosticUnderlineError gui=none guibg=#2e1f1f]]
vim.cmd [[hi DiagnosticUnderlineWarn gui=none guibg=#3f3122]]
vim.cmd [[hi DiagnosticUnderlineInfo gui=none guibg=#22373f]]
vim.cmd [[hi DiagnosticUnderlineHint gui=none guibg=#271f2e]]
vim.cmd [[hi DiagnosticVirtualTextError guibg=none]]
vim.cmd [[hi DiagnosticVirtualTextWarn guibg=none]]
vim.cmd [[hi DiagnosticVirtualTextInfo guibg=none]]
vim.cmd [[hi DiagnosticVirtualTextHint guibg=none]]
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
      dependencies = { 'lewis6991/gitsigns.nvim' },
      config = function()
         require("mini.statusline").setup({
            content = {
               active = function()
                  local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
                  local git = MiniStatusline.section_git({ trunc_width = 75 })
                  local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
                  local filename = MiniStatusline.section_filename({ trunc_width = 120 })
                  return MiniStatusline.combine_groups({
                     { hl = "Visual", strings = { mode } },
                     { hl = "MiniStatuslineDevinfo", strings = { git } },
                     "%<", -- Mark general truncate point
                     { hl = "MiniStatuslineFilename", strings = { filename } },
                     "%=", -- End left alignment
                     { hl = "MiniStatuslineDevinfo", strings = { diagnostics } },
                  })
               end,
               inactive = nil,
            },

            -- Whether to use icons by default
            use_icons = false,
            set_vim_settings = false,
         })
         vim.o.laststatus = 3
      end
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
