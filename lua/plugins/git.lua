return {
   -- 'tpope/vim-fugitive',
   'sindrets/diffview.nvim',
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
