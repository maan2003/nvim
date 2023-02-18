vim.cmd [[autocmd FileType * set formatoptions-=o]]
return {
   {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      opts = {},
   },
   -- {
   --     "echasnovski/mini.pairs",
   --     event = "VeryLazy",
   --     config = function(_, opts)
   --       require("mini.pairs").setup(opts)
   --     end,
   -- }
   {
      'phaazon/hop.nvim',
      keys = {
         { 'm', '<cmd>HopChar1<cr>', mode = { 'n', 'o', 'x' } },
      },
      cmd = { 'HopChar1' },
      opts = { keys = 'arstdhneiofuvkpl' },
   },
   {
      'sbdchd/neoformat',
      cmd = { 'Neoformat' },
   },
   {
      'LionC/nest.nvim',
      lazy = false,
      config = function()
         require('nest').applyKeymaps(require 'mxkeymap')
      end,
   },
   {
      'nmac427/guess-indent.nvim',
      opts = {},
   },
   { 'jghauser/mkdir.nvim', event = 'BufWritePre' },
   {
      "kylechui/nvim-surround",
      opts = {},
   },
   {
      'numToStr/Comment.nvim',
      opts = {},
   },

   {
      "chrisgrieser/nvim-various-textobjs",
      opts = { useDefaultKeymaps = true },
      enabled = false,
   },
   {
      "nvim-neo-tree/neo-tree.nvim",
      version = "v2.x",
      cmd = 'Neotree',
      dependencies = {
         "nvim-lua/plenary.nvim",
         "MunifTanjim/nui.nvim",
      }
   }
}
