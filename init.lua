local present, impatient = pcall(require, 'impatient')

if present then
  impatient.enable_profile()
end

vim.g.mapleader = ' '
require('options')
require('colors').init()

local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  _G.packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })

  vim.cmd([[packadd packer.nvim | lua require('plugins').sync()]])
end

if not _G.packer_bootstrap then
  local ok, _ = pcall(require, 'packer_compiled')
  if not ok then
    print('no packer_compiled')
  end
end

vim.defer_fn(function()
  require('mappings')
  require('commands')
end, 10)

local group = vim.api.nvim_create_augroup('start_screen', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
  command = "lua require'commands'.start_screen()",
  group = group,
  once = true,
  pattern = '*',
})
