-- <C-a>                   Copilot complete
-- <C-]>                   Dismiss the current suggestion.
-- <M-]>                   Cycle to the next suggestion, if one is available.
-- <M-[>                   Cycle to the previous suggestion.

require("copilot").setup({
	panel = {
		enabled = false,
	},
	suggestion = {
		auto_trigger = true,
	},
})
