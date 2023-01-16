vim.g.ui = {
	theme = "everforest-NvChad",
	changed_themes = {},
	theme_toggle = { "everforest", "everforest_light" },
	hl_add = {
		SpecsHL = { bg = "white" },
		MiniTablineFill = { bg = "darker_black" },
		MiniTablineCurrent = { fg = "white", bg = "black" },
		MiniTablineModifiedCurrent = { fg = "dark_purple", bg = "black" },
		MiniTablineModifiedHidden = { fg = "dark_purple", bg = "one_bg" },
		MiniTablineVisible = { fg = "light_grey", bg = "one_bg" },
		MiniTablineHidden = { fg = "light_grey", bg = "one_bg" },
		MatchParen = { bg = "grey" },
		markdownTSTitle = { bold = true, fg = "vibrant_green" },
		TSPunctSpecial = { bold = true, fg = "vibrant_green" },
		QuickFixLine = { bg = "black" },
		IndentBlanklineChar = { fg = "one_bg3" },
		IndentBlanklineContextChar = { fg = "dark_purple" },
		StatusLineGitAdd = { fg = "vibrant_green", bg = "statusline_bg" },
		StatusLineGitRemoved = { fg = "red", bg = "statusline_bg" },
		StatusLineGitChanged = { fg = "sun", bg = "statusline_bg" },
		StatusLineGitBranch = { fg = "grey_fg2", bg = "statusline_bg" },
		StatusLineLocation = { fg = "cyan", bg = "grey" },
		StatusLinePosition = { fg = "green", bg = "grey" },
		StatusLine = { bg = "statusline_bg", fg = "fg" },
		StatusLineFile = { fg = "white", bg = "lightbg" },
		StatusLineFileSep = { bg = "statusline_bg", fg = "lightbg" },
		StatusLinePositionIcon = { fg = "black", bg = "green" },
		StatusLinePositionIconSep = { bg = "grey", fg = "green" },
		StatusLineLocationSep = { fg = "grey", bg = "statusline_bg" },
		StatusLineError = { fg = "red" },
		StatusLineInfo = { fg = "green" },
		StatusLineHint = { fg = "dark_purple" },
		StatusLineWarn = { fg = "yellow" },
		MainSep = { fg = "cyan", bg = "lightbg", bold = true },
		Main = { bg = "cyan", fg = "lightbg", bold = true },
		ModeCSep = { fg = "green", bg = "lightbg", bold = true },
		ModeC = { bg = "green", fg = "lightbg", bold = true },
		ModeISep = { fg = "dark_purple", bg = "lightbg", bold = true },
		ModeI = { bg = "dark_purple", fg = "lightbg", bold = true },
		ModeTSep = { fg = "green", bg = "lightbg", bold = true },
		ModeT = { bg = "green", fg = "lightbg", bold = true },
		ModeNSep = { fg = "red", bg = "lightbg", bold = true },
		ModeN = { bg = "red", fg = "lightbg", bold = true },
		ModeVSep = { fg = "cyan", bg = "lightbg", bold = true },
		ModeV = { bg = "cyan", fg = "lightbg", bold = true },
		ModeRSep = { fg = "orange", bg = "lightbg", bold = true },
		ModeR = { bg = "orange", fg = "lightbg", bold = true },
	},
	hl_override = {
		NonText = { bg = "black" },
		Comment = { italic = true },
		Function = { italic = true },
		Error = { italic = true, bg = "grey" },
		Search = { fg = "white", bg = "grey" },
		CopilotSuggestion = { fg = "grey" },
	},
}

vim.g.theme = vim.g.ui.theme
vim.cmd.colorscheme(vim.g.theme)
