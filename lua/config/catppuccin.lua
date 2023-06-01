return {
	flavour = "frappe",
	integrations = {
		cmp = true,
		gitsigns = true,
		nvimtree = true,
		telescope = true,
		mini = true,
		-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
	},
	custom_highlights = function(colors)
		return {
			SpecsHL = { bg = colors.text },
			MiniTablineFill = { bg = colors.crust },
			MiniTablineCurrent = { fg = colors.text, bg = colors.mantle, style = {} },
			MiniTablineModifiedCurrent = { fg = colors.mauve, bg = colors.mantle },
			MiniTablineModifiedHidden = { fg = colors.mauve, bg = colors.surface0 },
			MiniTablineVisible = { fg = colors.overlay0, bg = colors.surface0 },
			MiniTablineHidden = { fg = colors.overlay0, bg = colors.surface0 },
			-- MatchParen = { bg = colors.surface1 },
			markdownTSTitle = { bold = true, fg = colors.green },
			TSPunctSpecial = { bold = true, fg = colors.green },
			-- QuickFixLine = { bg = colors.mantle },
			IndentBlanklineChar = { fg = colors.surface2 },
			IndentBlanklineContextChar = { fg = colors.mauve },
			TelescopePromptPrefix = { bg = colors.crust },
			TelescopePromptNormal = { bg = colors.crust },
			TelescopeResultsNormal = { bg = colors.mantle },
			TelescopePreviewNormal = { bg = colors.crust },
			TelescopePromptBorder = { bg = colors.crust, fg = colors.crust },
			TelescopeResultsBorder = { bg = colors.mantle, fg = colors.crust },
			TelescopePreviewBorder = { bg = colors.crust, fg = colors.crust },
			TelescopePromptTitle = { fg = colors.crust, bg = colors.green },
			TelescopeResultsTitle = { fg = colors.text, bg = colors.red },
			TelescopePreviewTitle = { fg = colors.crust, bg = colors.sapphire },
		}
	end,
}
