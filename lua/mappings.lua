local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

_G.project_files = function()
  local opts = {}
  local ok = pcall(require"telescope.builtin".git_files, opts)
  if not ok then require"telescope.builtin".find_files(opts) end
end

map('v', '<leader>y', '"+y')       -- Copy to clipboard in visual modes
map('n', '<leader>p', '"+p')       -- Copy to clipboard in visual modes

map('i', '<C-w>', '<C-g>u<C-w>')  -- Make <C-w> undo-friendly
-- <Tab> to navigate the completion menu
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

map('n', '<C-l>', '<cmd>noh<CR>')    -- Clear highlights
map('c', 'W', 'w')
map('', '<leader>o', '<cmd>lua project_files()<CR>')
map('', '<leader>c', ':Telescope colorscheme <CR>')
map('', '<leader>f', ':Telescope live_grep <CR>')
map('n', '<leader>s', ':source ~/.config/nvim/init.lua<CR>')
map('', '<leader>t', ':Telescope diagnostics bufnr=0<CR>')
vim.cmd [[
:cnoreabbrev wq w<bar>BufDel
:cnoreabbrev q BufDel
:cnoreabbrev Q q
]]
-- Shift + J/K moves selected lines down/up in visual mode
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")

-- Hop
map("n", "h", "<cmd>:HopWord<cr>")
map("n", "l", "<cmd>:HopLine<cr>")
map("v", "h", "<cmd>:HopWord<cr>")
map("v", "l", "<cmd>:HopLine<cr>")

-- LSP
vim.cmd[[
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gca   <cmd>:Telescope lsp_code_actions<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent><leader>fo <cmd>lua vim.lsp.buf.formatting()<CR>
]]
