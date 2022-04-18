_G.project_files = function()
  local opts = {}
  local ok = pcall(require('telescope.builtin').git_files, opts)
  if not ok then
    require('telescope.builtin').find_files(opts)
  end
end

function EscapePair()
  local closers = { ')', ']', '}', '>', "'", '"', '`', ',' }
  local line = vim.api.nvim_get_current_line()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local after = line:sub(col + 1, -1)
  local closer_col = #after + 1
  local closer_i = nil
  for i, closer in ipairs(closers) do
    local cur_index, _ = after:find(closer)
    if cur_index and (cur_index < closer_col) then
      closer_col = cur_index
      closer_i = i
    end
  end
  if closer_i then
    vim.api.nvim_win_set_cursor(0, { row, col + closer_col })
  else
    vim.api.nvim_win_set_cursor(0, { row, col + 1 })
  end
end

vim.cmd([[
:cnoreabbrev wq w<bar>BufDel
:cnoreabbrev q BufDel
:cnoreabbrev Q q
:cnoreabbrev W w
]])

local h = require('legendary.helpers')
local keys = {
  -- LEADER
  { '<leader>d', ':Neogen<CR>', description = 'Generate function documentation' },
  { '<leader>y', '"+y', description = 'Yank to global clipboard', mode = { 'n', 'v' } },
  { '<leader>p', '"+p', description = 'Paste from global clipboard' },
  { '<leader>o', '<cmd>lua project_files()<CR>', description = 'Open file search' },
  { '<leader>c', ':Telescope themes <CR>', description = 'Colorschemes' },
  { '<leader>f', ':Telescope live_grep <CR>', description = 'Search for word in folder' },
  { '<leader>r', ':source ~/.config/nvim/init.lua<CR>', description = 'Reload nvim config' },
  { '<leader>s', ':mksession<CR>', description = 'Save current files as a session' },
  { '<leader>t', ':Telescope diagnostics bufnr=0<CR>', description = 'Show file diagnostics' },
  { '<leader>fo', '<cmd>lua vim.lsp.buf.formatting()<CR>', description = 'Format buffer with LSP' },

  -- g
  { 'gca', '<cmd>Telescope lsp_code_actions<CR>', description = 'Code actions' },
  { 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', description = 'Go to definition' },
  { 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', description = 'Display hover tooltip' },
  { 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', description = 'Go to implementation ' },
  { 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', description = 'Go to type definition' },
  { 'gr', '<cmd>Telescope lsp_references<CR>', description = 'References' },
  { 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', description = 'Rename all references' },

  -- HOP
  { 'h', '<cmd>:HopWord<cr>', description = 'Hop Word' },
  { 'l', '<cmd>:HopLine<cr>', description = 'Hop Line' },
  { 's', '<cmd>:HopChar1<cr>', description = 'Hop 1 Char' },
  { 'S', '<cmd>:HopChar2<cr>', description = 'Hop 2 Char' },

  -- MISC
  { '<C-l>', '<cmd>noh<CR>', description = 'Clear highlighted text' },
  { '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', description = 'Function signature help' },

  { 'J', ":m '>+1<CR>gv=gv", description = 'Move down selected line', mode = { 'v' } },
  { 'K', ":m '<-2<CR>gv=gv", description = 'Move up selected line', mode = { 'v' } },

  -- TODO: document in README
  { '<C-c>', '<cmd>lua EscapePair()<CR>', description = 'Escape pairs while in insert mode', mode = { 'i' } },
  { '<C-w>', '<cmd>lua EscapePair()<CR>', description = 'Escape pairs while in insert mode', mode = { 'i' } },
}
require('legendary').setup({
  keymaps = keys,
})
