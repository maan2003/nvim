return {
   -- commands
   { 'xx', '<cmd>Telescope lsp_code_actions theme=cursor<cr>' },
   { mode = 'v', {
      { 'xx', "<cmd>'<,'>Telescope lsp_range_code_actions theme=cursor<cr>" },
   } },
   { 'xf', vim.lsp.buf.formatting },
   { 'xr', '<cmd>Telescope lsp_rename<cr>' },
   { mode = 'nvo', {
      { 'm', '<cmd>HopChar1<cr>' },
   } },

   -- lsp bindings
   { 'gg', '<cmd>Telescope lsp_definitions<cr>' },
   { 'gr', '<cmd>Telescope lsp_references<cr>' },
   { 'gt', '<cmd>Telescope lsp_type_definitions<cr>' },
   { 'gi', '<cmd>Telescope lsp_implementations<cr>' },
   { 'G', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>' },
   { 'ge', '<cmd>TroubleToggle workspace_diagnostics<cr>' },
   { 'gE', '<cmd>TroubleToggle<cr>' },
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
   { '<F9>t', '<cmd>ToggleTerm<cr>' },
   { '<F9>g', '<cmd>Neogit kind=split<cr>' },
   { '<F9>/', '<cmd>Telescope live_grep<cr>' },
   { mode = 't', { '<F9>t', '<cmd>ToggleTerm<cr>' } },
   -- { 'p', '<cmd>Telescope current_buffer_fuzzy_find<cr>' },
   -- { 'P', '<cmd>Telescope live_grep<cr>' },
   -- { '<a-x>', ':' },
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
