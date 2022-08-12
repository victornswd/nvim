_G.project_files = function()
  local opts = {}
  local ok = pcall(require('telescope.builtin').git_files, opts)
  if not ok then
    pcall(require('telescope.builtin').find_files, opts)
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

-- KEYS
-- LEADER
vim.keymap.set('n', '<leader>f', function()
  pcall(require('telescope.builtin').live_grep)
end, { desc = 'Search for word in folder' })
vim.keymap.set('n', '<leader>h', function()
  pcall(require('telescope.builtin').keymaps)
end, { desc = 'Show key maps' })
vim.keymap.set('n', '<leader>c', function()
  pcall(require('telescope').extensions.themes.themes)
end, { desc = 'Colorschemes' })
vim.keymap.set('n', '<leader>d', function()
  pcall(require('neogen').generate)
end, { desc = 'Generate function documentation' })

vim.keymap.set('n', '<leader>ma', function()
  pcall(require('harpoon.mark').add_file)
end, { desc = 'Add file to harpoon' })
vim.keymap.set('n', '<leader>ml', function()
  pcall(require('harpoon.ui').toggle_quick_menu)
end, { desc = 'List all harpoons' })
vim.keymap.set('n', '<leader>mc', function()
  pcall(require('harpoon.mark').rm_file)
end, { desc = 'Remove file from harpoon' })
vim.keymap.set('n', '<leader>mca', function()
  pcall(require('harpoon.mark').clear_all)
end, { desc = 'Remove all files from harpoon' })

vim.keymap.set('n', '<leader>t', function()
  pcall(require('telescope.builtin').diagnostics(), { bufnr = 0 })
end, { desc = 'Show file diagnostics' })
vim.keymap.set('n', '<leader>o', project_files, { desc = 'Open file search' })
vim.keymap.set('n', '<leader>fo', vim.lsp.buf.formatting, { desc = 'LSP - Format buffer with LSP' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to global clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste from global clipboard' })
vim.keymap.set('n', '<leader>r', ':source ~/.config/nvim/init.lua<CR>', { desc = 'Reload nvim config' })
vim.keymap.set('n', '<leader>s', ':mksession<CR>', { desc = 'Save current files as a session' })

-- g
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP - Go to declaration' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP - Go to definition' })
vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { desc = 'LSP - Display hover tooltip' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'LSP - Go to implementation' })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'LSP - Go to type definition' })
vim.keymap.set('n', 'gR', vim.lsp.buf.rename, { desc = 'LSP - Rename all references' })
vim.keymap.set('n', 'gr', function()
  pcall(require('telescope.builtin').lsp_references)
end, { desc = 'LSP - References' })
vim.keymap.set('n', 'gca', function()
  pcall(require('telescope.builtin').lsp_code_actions)
end, { desc = 'LSP - Code actions' })

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts, { desc = 'LSP - Open Diag' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts, { desc = 'LSP - Go to previous diag' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts, { desc = 'LSP - Go to next diag' })
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts, { desc = 'LSP - Add all diagnostics to loclist' })

-- CTRL
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'LSP - Function signature help' })
-- TODO: document in README
vim.keymap.set('i', '<C-c>', EscapePair, { desc = 'Escape pairs while in insert mode' })
vim.keymap.set('i', '<C-w>', EscapePair, { desc = 'Escape pairs while in insert mode' })
vim.keymap.set('n', '<C-l>', '<cmd>noh<CR>', { desc = 'Clear highlighted text' })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move down selected line' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move up selected line' })

-- HOP
local iz, hop = pcall(require, 'hop')
if iz then
  vim.keymap.set('n', '<leader>/', hop.hint_patterns, { desc = 'Hop Pattern' })
  vim.keymap.set('n', 'h', hop.hint_words, { desc = 'Hop Word' })
  vim.keymap.set('n', 'l', hop.hint_lines, { desc = 'Hop Line' })
  vim.keymap.set('n', 's', hop.hint_char1, { desc = 'Hop 1 Char' })
  vim.keymap.set('n', 'S', hop.hint_char2, { desc = 'Hop 2 Char' })
end
