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
require("lazy").setup({
	spec = {
		{ import = "plugins" },
		{ import = "config.lsp.servers.tailwind" },
		{ import = "config.lsp.servers.typescript" },
	},
	install = { colorscheme = { "catppuccin" } },
	change_detection = { notify = false },
	performance = {
		rtp = {
			-- disable some rtp plugins
			disabled_plugins = {
				"gzip",
				-- "matchit",
				-- "matchparen",
				-- "netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

require("options")
vim.cmd.colorscheme("catppuccin")

vim.defer_fn(function()
	require("keymaps")
	require("commands")
end, 10)
