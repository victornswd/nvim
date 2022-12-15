function EscapePair()
  local closers = { ")", "]", "}", ">", "'", '"', "`", "," }
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
:cnoreabbrev Q q
:cnoreabbrev W w ++p
]])

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump down 1/2 screen" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump up 1/2 screen" })

-- Harpoon
vim.keymap.set("n", "<C-1>", function()
  pcall(function()
    require("harpoon.ui").nav_file(1)
  end)
end, { desc = "Go to first Harpoon" })
vim.keymap.set("n", "<C-2>", function()
  pcall(function()
    require("harpoon.ui").nav_file(2)
  end)
end, { desc = "Go to second Harpoon" })
vim.keymap.set("n", "<C-3>", function()
  pcall(function()
    require("harpoon.ui").nav_file(3)
  end)
end, { desc = "Go to third Harpoon" })
vim.keymap.set("n", "<C-4>", function()
  pcall(function()
    require("harpoon.ui").nav_file(4)
  end)
end, { desc = "Go to fourth Harpoon" })

vim.keymap.set("n", "<leader>ma", function()
  pcall(require("harpoon.mark").add_file)
end, { desc = "Add file to harpoon" })
vim.keymap.set("n", "<leader>ml", function()
  pcall(require("harpoon.ui").toggle_quick_menu)
end, { desc = "List all harpoons" })
vim.keymap.set("n", "<leader>mc", function()
  pcall(require("harpoon.mark").rm_file)
end, { desc = "Remove file from harpoon" })
vim.keymap.set("n", "<leader>mca", function()
  pcall(require("harpoon.mark").clear_all)
end, { desc = "Remove all files from harpoon" })

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to global clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from global clipboard" })
vim.keymap.set("n", "<leader>r", ":source ~/.config/nvim/init.lua<CR>", { desc = "Reload nvim config" })
vim.keymap.set("n", "<leader>s", ":mksession<CR>", { desc = "Save current files as a session" })

-- TODO: document in README
vim.keymap.set("i", "<C-c>", EscapePair, { desc = "Escape pairs while in insert mode" })
vim.keymap.set("i", "<C-w>", EscapePair, { desc = "Escape pairs while in insert mode" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move down selected line" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move up selected line" })

function HL_search()
  local ns = vim.api.nvim_create_namespace("search")
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

  local sc = vim.fn.searchcount()
  vim.api.nvim_buf_set_extmark(0, ns, vim.api.nvim_win_get_cursor(0)[1] - 1, 0, {
    virt_text = { { "[" .. sc.current .. "/" .. sc.total .. "]", "Comment" } },
    virt_text_pos = "eol",
  })
end
vim.keymap.set("n", "n", "nzz:lua HL_search()<CR>", { desc = "Inline search occurence" })
vim.keymap.set("n", "N", "Nzz:lua HL_search()<CR>", { desc = "Inline search occurence" })
