-- --------------------- VIMWIKI ------------------------------
-- vim.cmd([[
-- let g:vimwiki_list = [{'path': '~/Dropbox/wiki/',
--                       \ 'syntax': 'markdown', 'ext': '.md'}]
-- let g:vimwiki_global_ext = 0
-- ]])

-------------------- COMMANDS ------------------------------
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 700 })
	end,
	group = highlight_group,
	pattern = "*",
})

-- don't auto commenting new lines
local cmnt_group = vim.api.nvim_create_augroup("CommentLine", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
	command = "set fo-=c fo-=r fo-=o",
	group = cmnt_group,
	pattern = "*",
})
