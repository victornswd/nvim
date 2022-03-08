local function start_screen()
  if vim.fn.argc() ~= 0 or vim.fn.line2byte '$' ~= -1 or vim.o.insertmode or not vim.o.modifiable then
    vim.cmd [[ doautocmd User ActuallyEditing ]]
    return
  end

  vim.cmd [[set eventignore=all]]
  vim.cmd [[noautocmd setlocal nomodifiable nomodified]]
  vim.cmd [[set eventignore=""]]
  vim.cmd [[ doautocmd User ActuallyEditing ]]
end

-------------------- PLUGINS -------------------------------
vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
  ]],
  false
)

vim.cmd [[command! PackerInstall packadd packer.nvim | lua require('plugins').install()]]
vim.cmd [[command! PackerUpdate packadd packer.nvim | lua require('plugins').update()]]
vim.cmd [[command! PackerSync packadd packer.nvim | lua require('plugins').sync()]]
vim.cmd [[command! PackerStatus packadd packer.nvim | lua require('plugins').status()]]
vim.cmd [[command! PackerClean packadd packer.nvim | lua require('plugins').clean()]]
vim.cmd [[command! PackerCompile packadd packer.nvim | lua require('plugins').compile()]]

--------------------- VIMWIKI ------------------------------
vim.cmd [[
let g:vimwiki_list = [{'path': '~/Dropbox/wiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0
]]

-------------------- COMMANDS ------------------------------
vim.cmd 'au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}'

-- don't auto commenting new lines
vim.cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

return { start_screen = start_screen }
