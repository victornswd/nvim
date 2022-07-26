local present, impatient = pcall(require, 'impatient')

if present then
  impatient.enable_profile()
end

vim.g.mapleader = ' '
require('options')

vim.g.ui = {
  theme = 'everforest-NvChad',
  -- theme = 'slate',
  changed_themes = {},
  theme_toggle = { 'everforest', 'everforest_light' },
  hl_add = {
    SpecsHL = { bg = 'white' },
    MiniTablineFill = { bg = 'darker_black' },
    MiniTablineCurrent = { fg = 'white', bg = 'black' },
    MiniTablineModifiedCurrent = { fg = 'dark_purple', bg = 'black' },
    MiniTablineModifiedHidden = { fg = 'dark_purple', bg = 'one_bg' },
    MiniTablineVisible = { fg = 'light_grey', bg = 'one_bg' },
    MiniTablineHidden = { fg = 'light_grey', bg = 'one_bg' },
    MatchParen = { bg = 'grey' },
    markdownTSTitle = { bold = true, fg = 'vibrant_green' },
    TSPunctSpecial = { bold = true, fg = 'vibrant_green' },
    QuickFixLine = { bg = 'black' },
    IndentBlanklineChar = { fg = 'one_bg3' },
    IndentBlanklineContextChar = { fg = 'dark_purple' },
  },
  hl_override = {
    Comment = { italic = true },
    Function = { italic = true },
    Error = { italic = true, bg = 'grey' },
  },
}
vim.g.theme = vim.g.ui.theme

local i, _ = string.find(vim.g.theme, '-NvChad')
if i then
  require('base46').load_theme()
else
  vim.cmd('colo ' .. vim.g.theme)
end

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
  require('config.status')
end, 10)

local group = vim.api.nvim_create_augroup('start_screen', { clear = true })
vim.api.nvim_create_autocmd('VimEnter', {
  command = "lua require'commands'.start_screen()",
  group = group,
  once = true,
  pattern = '*',
})
