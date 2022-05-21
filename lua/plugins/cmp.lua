local use = require('packer').use

use 'hrsh7th/nvim-cmp'
use 'hrsh7th/cmp-nvim-lsp'
use 'L3MON4D3/LuaSnip'

vim.cmd [[set completeopt=menu,menuone,noselect]]

local cmp = require 'cmp'

cmp.setup {
   snippet = {
      expand = function(args)
         require('luasnip').lsp_expand(args.body)
      end,
   },
   mapping = {
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm { select = true },
   },
   sources = {
      { name = 'nvim_lsp' },
   },
   completion = {
      get_trigger_characters = function(chars)
         return chars
      end,
      keyword_length = 2,
   },
}
