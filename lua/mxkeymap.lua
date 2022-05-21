return {
   {
      -- x = visual - select
      mode = 'nxo',
      {
         { 'n', 'j' },
         { 'e', 'k' },
         { 'i', 'w' },
         { 'm', 'b' },
         { 'y', 'h' },
         { 'o', 'l' },
         { 'u', '$l' },
         { 'l', '^' },
         { 'L', '0' },
         { '>', 'G' },
         { '<', 'gg' },
         -- actions
         { 't', 'd' },
         { 'r', 'c' },
         { '<s-t>', 'y' },
         { 's', 'P' },
         { 'h', '<cmd>HopChar1<cr>' },
         { 'z', '=='}
      },
   },
   -- getting into insert mode
   { 'v', 'i' },
   { '<s-v>', 'o' },
   { '<c-v>', '<s-o>' },
   -- AltGr-v
   { '"', 'A' },
   -- undo redo
   { '-', 'u' },
   { '_', '<c-r>' },
   -- visual mode
   { '<space>', 'V' },
   { '<s-space>', 'v' },
   { '<c-space>', '<c-v>' },

   -- commands
   { 'dd', '<cmd>Telescope lsp_code_actions theme=cursor<cr>'},
   { mode = 'v', {
      { 'dd', require('lsp-fastaction').range_code_action },
   } },
   { 'df', vim.lsp.buf.formatting },
   { 'dr', '<cmd>Telescope lsp_rename<cr>' },

   -- lsp bindings
   { 'gg', '<cmd>Telescope lsp_definitions<cr>' },
   { 'gr', '<cmd>Telescope lsp_references<cr>' },
   { 'gt', '<cmd>Telescope lsp_type_definitions<cr>' },
   { 'gi', '<cmd>Telescope lsp_implementations<cr>' },
   { 'G', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>' },
   { 'ge', '<cmd>TroubleToggle lsp_workspace_diagnostics<cr>' },
   { 'gE', '<cmd>TroubleToggle<cr>' },
   { 'gu', '<cmd>RustParentModule<cr>' },

   -- pop tag or go back
   { 'K', '<c-t>' },
   { '<F9>s', '<cmd>w<cr>' },
   { '<F9>k', '<cmd>bd<cr>' },
   { '<F9>f', '<cmd>Telescope find_files<cr>' },
   { '<F9>o', '<c-w><c-o>' },

   --
   { '<F9>b', '<cmd>Telescope buffers<cr>' },
   { '<F9>F', '<cmd>Telescope frecency<cr>' },
   { '<F9>p', '<cmd>Telescope projects theme=dropdown<cr>' },
   { '<F9>t', '<cmd>ToggleTerm<cr>' },
   { '<F9>g', '<cmd>Neogit kind=split<cr>' },
   { mode = 't', { '<F9>t', '<cmd>ToggleTerm<cr>' } },
   { 'p', '<cmd>Telescope current_buffer_fuzzy_find<cr>' },
   { 'P', '<cmd>Telescope live_grep<cr>' },
   { '<a-x>', ':' },
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
