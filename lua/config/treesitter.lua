-- local i, j = string.find(vim.g.theme, "-NvChad")
-- if i then
-- 	require("base46").load_highlight("syntax")
-- 	require("base46").load_highlight("treesitter")
-- end

require("nvim-treesitter.install").compilers = { "gcc" }
local ts = require("nvim-treesitter.configs")
ts.setup({
	ensure_installed = {
		"lua",
		"vim",
		"javascript",
		"typescript",
		"tsx",
		"elm",
		"bash",
		"toml",
		"yaml",
		"astro",
		"json",
		"markdown",
		"markdown_inline",
		"prisma",
		"query",
		"rust",
		"css",
		"templ",
	},
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
		},
	},
	indent = {
		enable = false,
	},
	refactor = {
		highlight_definitions = {
			enable = nvim_treesitter.enable_config.highlight_definitions,
			disable = base_disable_check,
			clear_on_cursor_move = false,
		},
		highlight_current_scope = {
			enable = nvim_treesitter.enable_config.highlight_current_scope,
			disable = extension_disable_check,
		},
	},
	matchup = {
		enable = true, -- mandatory, false will disable the whole extension
		matchparen = { offscreen = {} },
	},
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil,
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
	textobjects = {
		select = {
			enable = true,

			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,

			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		lsp_interop = {
			enable = true,
			border = "none",
			peek_definition_code = {
				["<leader>df"] = "@function.outer",
				["<leader>dF"] = "@class.outer",
			},
		},
	},
	autotag = {
		enable = true,
	},
})
