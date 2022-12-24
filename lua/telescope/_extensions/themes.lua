-- Edited from https://github.com/NvChad/extensions/blob/main/lua/telescope/_extensions/themes.lua
-- Most of the code is copied from telescope colorscheme plugin, mostly for preview creation
local function theme_switcher(opts)
	local pickers, finders, previewers, actions, action_state, utils, conf
	if pcall(require, "telescope") then
		pickers = require("telescope.pickers")
		finders = require("telescope.finders")
		previewers = require("telescope.previewers")

		actions = require("telescope.actions")
		action_state = require("telescope.actions.state")
		utils = require("telescope.utils")
		conf = require("telescope.config").values
	else
		error("Cannot find telescope!")
	end

	local colors = vim.fn.getcompletion("", "color")

	local function clear_cmdline()
		vim.defer_fn(function()
			vim.cmd.echo()
		end, 0)
	end

	-- 1st arg - r or w
	-- 2nd arg - file path
	-- 3rd arg - content if 1st arg is w
	-- return file data on read, nothing on write
	local function file_fn(mode, filepath, content)
		local data
		local fd = assert(vim.loop.fs_open(filepath, mode, 438))
		local stat = assert(vim.loop.fs_fstat(fd))
		if stat.type ~= "file" then
			data = false
		else
			if mode == "r" then
				data = assert(vim.loop.fs_read(fd, stat.size, 0))
			else
				assert(vim.loop.fs_write(fd, content, 0))
				data = true
			end
		end
		assert(vim.loop.fs_close(fd))
		return data
	end

	local function change_theme(current_theme, new_theme)
		if current_theme == nil or new_theme == nil then
			print("Error: Provide current and new theme name")
			return false
		end
		if current_theme == new_theme then
			return
		end

		local file = vim.fn.stdpath("config") .. "/init.lua"

		-- store in data variable
		local data = assert(file_fn("r", file))
		-- escape characters which can be parsed as magic chars
		current_theme = current_theme:gsub("%p", "%%%0")
		new_theme = new_theme:gsub("%p", "%%%0")
		local find = "theme = .?" .. current_theme .. ".?,"
		local replace = 'theme = "' .. new_theme .. '",'
		local content = string.gsub(data, find, replace)
		-- see if the find string exists in file
		if content == data then
			print("Error: Cannot change default theme with " .. new_theme .. ", edit " .. file .. " manually")
			return false
		else
			assert(file_fn("w", file, content))
		end
	end
	local function reload_theme(theme_name)
		-- if theme name is empty or nil, then reload the current theme
		if theme_name == nil or theme_name == "" then
			theme_name = vim.g.theme
		end

		vim.g.theme = theme_name
		local i, _ = string.find(theme_name, "-NvChad")
		if i then
			require("base46").load_all_highlights()
			vim.opt.bg = require("base46").get_theme_tb("type")
		end

		return true
	end

	-- get a table of available themes
	if next(colors) ~= nil then
		-- save this to use it for later to restore if theme not changed
		local current_theme = vim.g.theme
		local new_theme = ""
		local change = false

		-- buffer number and name
		local bufnr = vim.api.nvim_get_current_buf()
		local bufname = vim.api.nvim_buf_get_name(bufnr)

		local previewer

		-- in case its not a normal buffer
		-- if vim.fn.buflisted(bufnr) ~= 1 then
		--   local deleted = false
		--   local function del_win(win_id)
		--     if win_id and vim.api.nvim_win_is_valid(win_id) then
		--       utils.buf_delete(vim.api.nvim_win_get_buf(win_id))
		--       pcall(vim.api.nvim_win_close, win_id, true)
		--     end
		--   end
		--
		--   previewer = previewers.new({
		--     preview_fn = function(_, entry, status)
		--       if not deleted then
		--         deleted = true
		--         del_win(status.preview_win)
		--         del_win(status.preview_border_win)
		--       end
		--       print('THAT' .. entry.value)
		--       -- reload_theme(entry.value)
		--       -- vim.cmd.colorscheme(entry.value)
		--     end,
		--   })
		-- else
		-- show current buffer content in previewer
		previewer = previewers.new_buffer_previewer({
			define_preview = function(self, entry)
				local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
				vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
				local filetype = require("plenary.filetype").detect(bufname) or "diff"

				require("telescope.previewers.utils").highlighter(self.state.bufnr, filetype)
				-- reload_theme(entry.value)
				-- print('THIS ' .. entry.value)
				vim.cmd.colorscheme(entry.value)
			end,
		})
		-- end

		local picker = pickers.new({
			prompt_title = "Change Colorscheme",
			finder = finders.new_table(colors),
			previewer = previewer,
			sorter = conf.generic_sorter(opts),
			attach_mappings = function()
				actions.select_default:replace(
					-- if a entry is selected, change current_theme to that
					function(prompt_bufnr)
						local selection = action_state.get_selected_entry()
						new_theme = selection.value
						change = true
						actions.close(prompt_bufnr)
					end
				)
				return true
			end,
		})

		-- rewrite picker.close_windows
		local close_windows = picker.close_windows
		picker.close_windows = function(status)
			-- now apply the theme, if success, then ask for default theme change
			local final_theme
			if change then
				final_theme = new_theme
			else
				final_theme = current_theme
			end

			if reload_theme(final_theme) then
				if change then
					-- ask for confirmation to set as default theme
					local ans = string.lower(vim.fn.input("Set " .. new_theme .. " as default theme ? [y/N] ")) == "y"
					clear_cmdline()
					if ans then
						change_theme(current_theme, final_theme)
						-- _G.base_color = final_theme
					else
						-- will be used in restoring nvchad theme var
						final_theme = current_theme
					end
				end
			else
				final_theme = current_theme
			end
			-- set nvchad_theme global var
			vim.g.theme = final_theme
			close_windows(status)
		end
		-- launch the telescope picker
		picker:find()
	else
		print("No themes found")
	end
end

-- register theme swticher as themes to telescope
local present, telescope = pcall(require, "telescope")
if present then
	return telescope.register_extension({
		exports = {
			themes = theme_switcher,
		},
	})
else
	error("Cannot find telescope!")
end
