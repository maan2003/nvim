local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
   packer_bootstrap = vim.fn.system {
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path,
   }
   vim.api.nvim_command 'packadd packer.nvim'
end

require 'options'
require('packer').startup(function(use)
   use 'wbthomason/packer.nvim'
   require 'plugins/eye-candy'
   require 'mxkeymap'
   require 'plugins/main'
   require 'plugins/lsp'
   require 'plugins/ts'
   require 'plugins/tele'
   require 'plugins/cmp'
   require 'plugins/git'

   if packer_bootstrap then
      require('packer').sync()
   end
end)
