local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

require("lualine").setup({
	options = {
		component_separators = "",
		section_separators = "",
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { { "branch", icon = "" } },
		lualine_c = {
			{
				"diff",
				source = diff_source,
				padding = { left = 1, right = 0 },
				symbols = {
					added = " ",
					modified = " ",
					removed = " ",
				},
			},
			{ "filetype", icon_only = true, separator = "", padding = { right = 0, left = 1 } },
			"filename",
		},
		lualine_x = {
			{
				"diagnostics",
				symbols = {
					error = " ",
					warn = " ",
					info = " ",
					hint = " ",
				},
			},
		},
		lualine_y = { "location" },
		lualine_z = { "progress" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	winbar = {},
})
