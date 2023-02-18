local fancy_n = require 'fancyn'
return {
   -- commands
   {
      'xe',
      function()
         local old = vim.diagnostic.config().virtual_lines
         if old then
            local min_warn = { min = vim.diagnostic.severity.WARN }
            vim.diagnostic.config {
               virtual_text = {
                  severity = min_warn,
                  prefix = '',
                  format = function(diag)
                     if diag.message:match 'Unused' then
                        return ""
                     else
                        return diag.message
                     end
                  end,
               },
               underline = {
                  severity = min_warn,
               },
               virtual_lines = false,
            }
         else
            vim.diagnostic.config {
               underline = true,
               virtual_lines = true,
               virtual_text = false,
            }
         end
      end,
   },
   { 'n', fancy_n.n },
   { 'N', fancy_n.N },
   { '/', fancy_n.search },
   {
      'gE',
      function()
         fancy_n.set_mode(fancy_n.modes.diagnostics)
      end,
   },
   {
      'gq',
      function()
         fancy_n.set_mode(fancy_n.modes.quickfixlist)
      end,
   },
   {
      'gl',
      function()
         fancy_n.set_mode(fancy_n.modes.locationlist)
      end,
   },
   {
      'ge',
      function()
         fancy_n.set_mode(fancy_n.modes.quickfixlist)
         vim.diagnostic.setqflist { open = false, severity = vim.diagnostic.severity.ERROR }
         xpcall(vim.cmd, function(err)
            print_error(string.gsub(err, [[^Vim%(.*%):]], ''))
         end, 'crewind')
      end,
   },
   { '<Leader>s', '<cmd>w<cr>' },
   { '<Leader>k', '<cmd>bd<cr>' },
   { '<Leader>f', '<cmd>Telescope find_files<cr>' },
   { '<Leader>o', '<c-w><c-o>' },
   { '<Leader>0', '<cmd>close<cr>' },
   { '<Leader>1', '<cmd>split<cr>' },
   { '<Leader>2', '<cmd>vsplit<cr>' },

   { '<Leader>q', '<c-w>q' },
   { '<Leader><s-q>', '<c-w><c-q>' },

   -- insert mode
   {
      mode = 'i',
      {
         -- move to last insert location after Esc to avoid left shift
         { '<F9>', '<Esc>`^' },
      },
   },
}
