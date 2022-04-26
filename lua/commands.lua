local function start_screen()
  if vim.fn.argc() ~= 0 or vim.fn.line2byte('$') ~= -1 or vim.o.insertmode or not vim.o.modifiable then
    vim.cmd([[ doautocmd User ActuallyEditing ]])
    return
  end

  vim.cmd([[set eventignore=all]])
  vim.cmd([[noautocmd setlocal nomodifiable nomodified]])
  vim.cmd([[set eventignore=""]])
  vim.cmd([[ doautocmd User ActuallyEditing ]])
end

-------------------- PLUGINS -------------------------------
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd(
  'BufWritePost',
  { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'lua/plugin-list.lua' }
)

vim.api.nvim_create_user_command(
  'PackerInstall',
  "packadd packer.nvim | lua require('plugins').install()",
  { bang = false }
)
vim.api.nvim_create_user_command(
  'PackerUpdate',
  "packadd packer.nvim | lua require('plugins').update(()",
  { bang = false }
)
vim.api.nvim_create_user_command('PackerSync', "packadd packer.nvim | lua require('plugins').sync()", { bang = false })
vim.api.nvim_create_user_command(
  'PackerStatus',
  "packadd packer.nvim | lua require('plugins').status()",
  { bang = false }
)
vim.api.nvim_create_user_command(
  'PackerClean',
  "packadd packer.nvim | lua require('plugins').clean()",
  { bang = false }
)
vim.api.nvim_create_user_command(
  'PackerCompile',
  "packadd packer.nvim | lua require('plugins').compile()",
  { bang = false }
)

--------------------- VIMWIKI ------------------------------
vim.cmd([[
let g:vimwiki_list = [{'path': '~/Dropbox/wiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0
]])

-------------------- COMMANDS ------------------------------
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 700 })
  end,
  group = highlight_group,
  pattern = '*',
})

-- don't auto commenting new lines
local cmnt_group = vim.api.nvim_create_augroup('CommentLine', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  command = 'set fo-=c fo-=r fo-=o',
  group = cmnt_group,
  pattern = '*',
})

return { start_screen = start_screen }
