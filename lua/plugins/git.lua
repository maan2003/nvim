return {
   -- 'tpope/vim-fugitive',
   'sindrets/diffview.nvim',
   {
      'lewis6991/gitsigns.nvim',
      opts = {},
   },
   {
      'TimUntersberger/neogit',
      cmd = { 'Neogit' },
      opts = {
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
   }
}
