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

vim.keymap.set("ca", "Q", "q")
vim.keymap.set("ca", "W", "w ++p")
vim.keymap.set("ca", "w", "w ++p")

-- Harpoon
vim.keymap.set("n", "<M-1>", function()
	pcall(function()
		require("harpoon.ui").nav_file(1)
	end)
end, { desc = "Go to first Harpoon" })
vim.keymap.set("n", "<M-2>", function()
	pcall(function()
		require("harpoon.ui").nav_file(2)
	end)
end, { desc = "Go to second Harpoon" })
vim.keymap.set("n", "<M-3>", function()
	pcall(function()
		require("harpoon.ui").nav_file(3)
	end)
end, { desc = "Go to third Harpoon" })
vim.keymap.set("n", "<M-4>", function()
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
vim.keymap.set("n", "<leader>s", ":mksession<CR>", { desc = "Save current files as a session" })

-- TODO: document in README
vim.keymap.set("i", "<C-c>", EscapePair, { desc = "Escape pairs while in insert mode" })
vim.keymap.set("i", "<C-w>", EscapePair, { desc = "Escape pairs while in insert mode" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Jump down 1/2 screen" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Jump up 1/2 screen" })

vim.keymap.set("n", "<M-w>", ":set wrap!<CR>", { desc = "Toggle word wrap" })

-- Mouse context menu
vim.api.nvim_create_autocmd({ "LspAttach" }, {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client.server_capabilities.hoverProvider then
			vim.cmd.aunmenu({ "PopUp" })
			vim.cmd.anoremenu({ "PopUp.Go\\ to\\ Definition <Cmd>lua vim.lsp.buf.definition()<CR>" })
			vim.cmd.anoremenu({
				"PopUp.Go\\ to\\ References <Cmd>lua pcall(require('telescope.builtin').lsp_references)<CR>",
			})
			vim.cmd.anoremenu({ "PopUp.Rename\\ Symbol <Cmd>lua vim.lsp.buf.rename()<CR>" })
		end
	end,
})

vim.keymap.set("n", "<leader><leader>", ":popup PopUp<CR>", { desc = "Show context menu" })
