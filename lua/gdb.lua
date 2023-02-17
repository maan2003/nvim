local use = require 'packer'.use
use {
   'Maan2003/nvim-gdb',
   run = './install.sh',
   config = function()
      local function gdb()
         return NvimGdb.i()
      end

      local function gdbsend(arg)
         return function()
            gdb():send(arg)
         end
      end

      dbg_mappings = {
         { 'n', gdbsend 'next' },
         { 's', gdbsend 'step' },
         { 'N', gdbsend 'reverse-next' },
         { 'f', gdbsend 'finish' },
         { 'F', gdbsend 'reverse-finish' },
         {
            'u',
            function()
               gdb():send('until "%s:%s"', vim.fn.expand '%:p', vim.fn.line '.')
            end,
         },
         {
            'U',
            function()
               gdb():send('until "%s:%s"', vim.fn.expand '%:p', vim.fn.line '.')
            end,
         },
         { 'c', gdbsend 'continue' },
         { 'C', gdbsend 'reverse-continue' },
         -- TODO: treesitter expr
         { 'p', '<cmd>GdbEvalWord<cr>' },
         {
            'a',
            function()
               gdb():send('advance "%s:%s"', vim.fn.expand '%:p', vim.fn.line '.')
            end,
         },
         {
            'd',
            function()
               gdb():breakpoint_toggle()
            end,
         },
         { '<C-u>', gdbsend 'up' },
         { '<C-d>', gdbsend 'down' },
      }

      require('nvimgdb.config').setup {
         set_keymaps = function()
            require('nest').applyKeymaps {
               buffer = true,
               options = { nowait = true, noremap = true },
               dbg_mappings,
            }
         end,
         unset_keymaps = function()
            for _, value in ipairs(dbg_mappings) do
               vim.api.nvim_buf_del_keymap(0, 'n', value[1])
            end
         end,
      }

      vim.cmd [[hi link GdbCurrentLineSign CursorLineNr]]
      vim.cmd [[hi GdbBreakpointSign guifg=#EA6962]]
   end,
}

local Gdb = require 'gdb_client_nvim'

local hl_namespace = vim.api.nvim_create_namespace 'nvim-dap-virtual-text'

vim.cmd[[autocmd User NvimGdbBreak lua mx_gdb.refresh()]]
vim.cmd[[autocmd User NvimGdbCleanup lua mx_gdb.clear()]]

vim.cmd[[
highlight default link NvimGdbVirtualText Comment
highlight default link NvimGdbVirtualTextChanged DiagnosticVirtualTextWarn
]]

local M = {}
_G.mx_gdb = M
function M.clear(buf) 
   buf = buf or 0
   vim.api.nvim_buf_clear_namespace(buf, hl_namespace, 0, -1)
end

local gdb = Gdb.new()

function M.eval(val)
   -- TODO: impl
end

local vars_viewer = require("vars_viewer")
local vars_visualizer = require("vars_visualizer")

local visualizers = {}

function M.refresh(buf)
   buf = buf or 0
   M.clear()

   local current_line = gdb:line_number() - 1;

   local status, variables = pcall(function () return gdb:variables() end)
   if not status then
      return
   end

   local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
   local env = vim.tbl_extend("keep", vars_visualizer.command_env, variables)

   local visuals = {}
   for i, line in ipairs(lines) do
      local mat = line:match(".*// DBG (.+)") 
      if mat then 
         print(mat)
         pcall(function () gdb:eval(mat) end)
         -- if not visualizers[mat] then
         --    visualizers[mat] = vars_visualizer.new(mat)
         -- end
         -- if visualizers[mat] then
         --    local vr = visualizers[mat].get(env)
         --    if vr then
         --       table.insert(visuals, vr)
         --    end
         -- end
      end
   end

   for _, vr in ipairs(visuals) do
      vr()
   end

   vars_viewer.view(buf, variables, current_line, hl_namespace)
end
