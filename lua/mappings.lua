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

local ok, wk = pcall(require, 'which-key')
-- local wk = require"which-key"
if ok then
  local map_normal_leader = {
    y = { '"+y', 'Yank to global clipboard' },
    p = { '"+p', 'Paste from global clipboard' },
    o = { '<cmd>lua project_files()<CR>', 'Open file search' },
    c = { ':Telescope themes <CR>', 'Colorschemes' },
    f = { ':Telescope live_grep <CR>', 'Search for word in folder' },
    r = { ':source ~/.config/nvim/init.lua<CR>', 'Reload nvim config' },
    s = { ':mksession<CR>', 'Save current files as a session' },
    t = { ':Telescope diagnostics bufnr=0<CR>', 'Show file diagnostics' },
    ['fo'] = { '<cmd>lua vim.lsp.buf.formatting()<CR>', 'Format buffer with LSP' },
  }
  wk.register({
    y = { '"+y', 'Yank to global clipboard' },
  }, { prefix = '<leader>', mode = 'v' })

  local map_normal_g = {
    c = {
      a = { '<cmd>Telescope lsp_code_actions<CR>', 'Code actions' },
    },
    d = { '<cmd>lua vim.lsp.buf.definition()<CR>', 'Go to definition' },
    h = { '<cmd>lua vim.lsp.buf.hover()<CR>', 'Display hover tooltip' },
    D = { '<cmd>lua vim.lsp.buf.implementation()<CR>', 'Go to implementation ' },
    t = { '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Go to type definition' },
    r = { '<cmd>Telescope lsp_references<CR>', 'References' },
    R = { '<cmd>lua vim.lsp.buf.rename()<CR>', 'Rename all references' },
  }

  -- Hop
  local map_hop = {
    h = { '<cmd>:HopWord<cr>', 'Hop Word' },
    l = { '<cmd>:HopLine<cr>', 'Hop Line' },
    s = { '<cmd>:HopChar1<cr>', 'Hop Line' },
    S = { '<cmd>:HopChar2<cr>', 'Hop Line' },
  }

  local misc_normal = {
    ['<C-l>'] = { '<cmd>noh<CR>', 'Clear highlighted text' },
    ['<C-k>'] = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'Function signature help' },
  }

  local misc_visual = {
    J = { ":m '>+1<CR>gv=gv", 'Move down selected line' },
    K = { ":m '<-2<CR>gv=gv", 'Move up selected line' },
  }

  -- TODO: document in README
  local misc_insert = {
    ['<C-w>'] = { '<C-g>u<C-w>', 'Make <C-w> undo-friendly' },
    ['<C-c>'] = { '<cmd>lua EscapePair()<CR>', 'Escape pairs while in insert mode' },
  }

  wk.register(map_normal_leader, { prefix = '<leader>' })
  wk.register(map_normal_g, { prefix = 'g' })
  wk.register(map_hop, { mode = 'n' })
  wk.register(map_hop, { mode = 'v' })
  wk.register(misc_normal, { mode = 'n' })
  wk.register(misc_visual, { mode = 'v' })
  wk.register(misc_insert, { mode = 'i' })
end
