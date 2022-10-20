pcall(require, 'impatient')
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

vim.cmd[[
let g:mapleader = "\<Space>"
nnoremap <Space> <Nop>
]]
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
   use 'lewis6991/impatient.nvim'
   use 'nvim-lua/popup.nvim'
   use 'nvim-lua/plenary.nvim'

   require 'plugins/eye-candy'
   require 'plugins/main'
   require 'plugins/lsp'
   require 'plugins/ts'
   require 'plugins/tele'
   require 'plugins/cmp'

   if packer_bootstrap then
      require('packer').sync()
   end
end)
vim.cmd[[
hi CmpItemKindDefault guifg=#d8a657
hi CmpItemAbbrDefault guifg=#ddc7a1
hi CmpItemAbbrMatchDefault guifg=#ddc7a1
hi CmpItemAbbrMatchFuzzyDefault guifg=#ddc7a1
]]

if vim.fn.getcwd():match("cp") then
   vim.cmd[[autocmd BufEnter *.cpp lua _CpAu()]]
   function _CpAu()
      if vim.fn.search("// headers {{{") == 0 then
         vim.cmd[[0r~/cp/web/template.cpp]]
      end
      vim.cmd[[setlocal foldmethod=marker foldlevel=0]]
   end
end
