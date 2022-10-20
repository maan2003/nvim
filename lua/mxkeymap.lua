local fancy_n = require 'fancyn'
return {
   -- commands
   { 'xx', vim.lsp.buf.code_action },
   { mode = 'x', {
      { 'xx', ':<c-u>lua vim.lsp.buf.range_code_action()<cr>' },
   } },
   { 'xf', function() vim.lsp.buf.format {asnyc = true} end },
   { 'xr', vim.lsp.buf.rename },
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
   { mode = 'nxo', {
      { 'm', '<cmd>HopChar1<cr>' },
   } },
   { 'n', fancy_n.n },
   { 'N', fancy_n.N },
   { '/', fancy_n.search },
   {
      'ge',
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
      'gE',
      function()
         fancy_n.set_mode(fancy_n.modes.quickfixlist)
         vim.diagnostic.setqflist { open = false, severity = vim.diagnostic.severity.ERROR }
         xpcall(vim.cmd, function(err)
            print_error(string.gsub(err, [[^Vim%(.*%):]], ''))
         end, 'crewind')
      end,
   },
   -- jump movement
   { '<down>', '<c-o>' }, -- CapsLock + k
   { '<up>', '<c-i>' }, -- CapsLock + i

   { '<left>', 'g;' }, -- CapsLock + j
   { '<ca-u>', 'g,' }, -- CapsLock + u

   -- lsp bindings
   { 'gd', '<cmd>Telescope lsp_definitions<cr>' },
   { 'gr', '<cmd>Telescope lsp_references<cr>' },
   { 'gt', '<cmd>Telescope lsp_type_definitions<cr>' },
   { 'gi', '<cmd>Telescope lsp_implementations<cr>' },
   { 'g<space>', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>' },
   { 'gu', '<cmd>RustParentModule<cr>' },

   { '<F9>s', '<cmd>w<cr>' },
   { '<F9>k', '<cmd>bd<cr>' },
   { '<F9>f', '<cmd>Telescope find_files<cr>' },
   { '<F9>o', '<c-w><c-o>' },
   { '<F9>0', '<cmd>close<cr>' },
   { '<F9>1', '<cmd>split<cr>' },
   { '<F9>2', '<cmd>vsplit<cr>' },

   --
   { '<F9>b', '<cmd>Telescope buffers<cr>' },
   { '<F9>F', '<cmd>Telescope frecency<cr>' },
   { '<F9>p', '<cmd>Telescope projects theme=dropdown<cr>' },
   { '<F9>g', '<cmd>Neogit kind=split<cr>' },
   { '<F9>/', '<cmd>Telescope live_grep<cr>' },
   {
      '<F9>t',
      function()
         local cwd = vim.fn.getcwd()
         local ses = 'term-' .. cwd
         vim.fn.jobstart(
            'tmux new-session -d -s '
               .. ses
               .. '; tmux switch-client -t '
               .. ses
               .. '; tmux set-option -t '
               .. ses
               .. " set-titles-string 'term - #T'"
         )
      end,
   },
   { '<F9>q', '<c-w>q' },
   { '<F9><s-q>', '<c-w><c-q>' },

   -- insert mode
   {
      mode = 'i',
      {
         -- move to last insert location after Esc to avoid left shift
         { '<F9>', '<Esc>`^' },
      },
   },
}
