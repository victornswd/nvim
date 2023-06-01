-- local i, j = string.find(vim.g.theme, "-NvChad")
-- if i then
-- 	require("base46").load_highlight("syntax")
-- 	require("base46").load_highlight("treesitter")
-- end

local nvim_treesitter = {}

nvim_treesitter.enable_config = {
	highlight_definitions = false,
	highlight_current_scope = false,
}

local get_buffer_variable = function(buf, var)
	local status, result = pcall(vim.api.nvim_buf_get_var, buf, var)
	if status then
		return result
	end
	return nil
end

local force_disable_var = "nvim_treesitter_force_disable"
local get_force_disable = function(bufnr)
	return get_buffer_variable(bufnr, force_disable_var) or false
end

-- Disable check for highlight, highlight usage, highlight context module
local disable_check = function(type, lang, bufnr)
	if get_force_disable(bufnr) then
		return true
	end
	if type == nil then
		type = "base"
	end

	local line_count = vim.api.nvim_buf_line_count(bufnr or 0)
	local line_threshold_map = vim.F.if_nil(nvim_treesitter.line_threshold[type], {})
	local line_threshold = line_threshold_map[lang]

	if line_threshold ~= nil and line_count > line_threshold then
		return true
	else
		return false
	end
end

-- Disable check for highlight module
local base_disable_check = function(lang, bufnr)
	return disable_check("base", lang, bufnr)
end

-- Disable check for highlight usage/context
local extension_disable_check = function(lang, bufnr)
	return disable_check("extension", lang, bufnr)
end

require("nvim-treesitter.install").compilers = { "gcc" }
local ts = require("nvim-treesitter.configs")
ts.setup({
	ensure_installed = {
		"lua",
		"vim",
		"help",
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

local check_condition = function(plugin_spec, condition)
	if condition then
		return plugin_spec
	else
		return nil
	end
end

local setup_performance_trick = function()
	local configs_commands = require("nvim-treesitter.configs").commands

	-- TODO: Check if these actually help performance, initial test reveals that these may reduce highlighter time, but increase "[string]:0" time which is probably the time spent on autocmd & syntax enable/disable.
	-- TODO: These config help reduce memory usage, see if there's other way to fix high memory usage.
	-- TODO: Change to tab based toggling
	local augroup_id = vim.api.nvim_create_augroup("nvim_treesitter_settings", {})

	local global_idle_disabled_modules = vim.tbl_filter(function(module)
		return module ~= nil
	end, {
		"highlight",
		"context_commentstring",
		"matchup",
		check_condition("highlight_current_scope", nvim_treesitter.enable_config.highlight_current_scope),
		check_condition("highlight_definitions", nvim_treesitter.enable_config.highlight_definitions),
		"navigation",
		"smart_rename",
	})
	local tab_idle_disabled_modules = global_idle_disabled_modules

	local global_trick_delay_enable = false
	local global_trick_delay = 60 * 1000 -- 60 seconds
	vim.api.nvim_create_autocmd({ "FocusGained" }, {
		group = augroup_id,
		pattern = "*",
		callback = function()
			if global_trick_delay_enable then
				global_trick_delay_enable = false
			else
				for _, module in ipairs(global_idle_disabled_modules) do
					configs_commands.TSEnable.run(module)
				end
			end
		end,
	})
	-- NOTE: We want to disable highlight if FocusLost is caused by following reasons:
	-- 1. neovim goes to background
	-- 2. tmux switch window, client
	-- 3. Terminal emulator switch tab
	-- We don't want to disable highlight if FocusLost is caused by following reasons:
	-- 1. tmux switch pane
	-- 2. Terminal emulator switch pane
	-- 3. OS switch application
	-- In other words, we want treesitter highlight if the buffer is actually displayed on the screen.
	vim.api.nvim_create_autocmd({ "FocusLost" }, {
		group = augroup_id,
		pattern = "*",
		callback = function()
			global_trick_delay_enable = true

			vim.defer_fn(function()
				if global_trick_delay_enable then
					for _, module in ipairs(global_idle_disabled_modules) do
						configs_commands.TSDisable.run(module)
					end

					global_trick_delay_enable = false
				end
			end, global_trick_delay)
		end,
	})
	local tab_trick_enable = false
	local tab_trick_debounce = 200
	-- FIXME: Open buffer in other tab doesn't have highlight
	-- FIXME: Seems to conflict with true-zen.nvim
	vim.api.nvim_create_autocmd({ "TabEnter" }, {
		group = augroup_id,
		pattern = "*",
		callback = function()
			tab_trick_enable = true

			vim.defer_fn(function()
				if tab_trick_enable then
					local winids = vim.api.nvim_tabpage_list_wins(0)

					for _, module in ipairs(tab_idle_disabled_modules) do
						for _, winid in ipairs(winids) do
							configs_commands.TSBufEnable.run(module, vim.api.nvim_win_get_buf(winid))
						end
					end

					tab_trick_enable = false
				end
			end, tab_trick_debounce)
		end,
	})
	vim.api.nvim_create_autocmd({ "TabLeave" }, {
		group = augroup_id,
		pattern = "*",
		callback = function()
			for _, winid in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
				for _, module in ipairs(tab_idle_disabled_modules) do
					configs_commands.TSBufDisable.run(module, vim.api.nvim_win_get_buf(winid))
				end
			end
		end,
	})
end

setup_performance_trick()
