local use = require('packer').use
use 'mfussenegger/nvim-dap'
use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

local dap = require('dap')
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = '/home/manmeet/bins/debugAdapters/bin/OpenDebugAD7',
}

dap.configurations.cpp = {
	{
		name = 'Attach to gdbserver :5000',
		type = 'cppdbg',
		request = 'launch',
		MIMode = 'gdb',
		miDebuggerServerAddress = '127.0.0.1:5000',
		miDebuggerPath = '/home/manmeet/bins/rr-gdb',
		cwd = '${workspaceFolder}',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
    setupCommands = {  
      { 
        text = '-enable-pretty-printing',
        description =  'enable pretty printing',
        ignoreFailures = false 
      },
    },
	},
}

vim.keymap.set('n', '<leader>k', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end)

