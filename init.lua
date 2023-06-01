local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
require("lazy").setup("plugins")

require("options")
vim.cmd.colorscheme("catppuccin")

vim.defer_fn(function()
	require("keymaps")
	require("conceal")
	require("commands")
end, 10)
