local present, impatient = pcall(require, "impatient")

if present then
  impatient.enable_profile()
end

vim.g.mapleader=' '
require('options')
require('colors')

require('packer_compiled')

require('mappings')
require('commands')

local function autocmd(group, cmds, clear)
  clear = clear == nil and false or clear
  if type(cmds) == 'string' then cmds = {cmds} end
  vim.cmd('augroup ' .. group)
  if clear then vim.cmd [[au!]] end
  for _, c in ipairs(cmds) do vim.cmd('autocmd ' .. c) end
  vim.cmd [[augroup END]]
end

autocmd('start_screen', [[VimEnter * ++once lua require'commands'.start_screen()]], true)
