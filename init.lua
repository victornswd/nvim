local present, impatient = pcall(require, 'impatient')

if present then
  impatient.enable_profile()
end

vim.g.mapleader = ' '
require('options')
require('colors').init()

local ok, _ = pcall(require, 'packer_compiled')
if not ok then
  print('no packer_compiled')
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
