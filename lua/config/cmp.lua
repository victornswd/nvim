return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "dcampos/cmp-snippy" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{ "hrsh7th/cmp-nvim-lua" },
	},
	opts = function()
		local lsp_symbols = {
			Text = " ",
			Method = " ",
			Function = " ",
			Constructor = " ",
			Field = " ",
			Variable = " ",
			Class = " ",
			Interface = "ﰮ ",
			Module = " ",
			Property = "襁 ",
			Unit = " ",
			Value = " ",
			Enum = " ",
			Keyword = " ",
			Snippet = "﬌ ",
			Color = " ",
			File = " ",
			Reference = " ",
			Folder = " ",
			EnumMember = " ",
			Constant = " ",
			Struct = " ",
			Event = " ",
			Operator = "ﬦ ",
			TypeParameter = " ",
			Copilot = " ",
		}

		local function border(hl_name)
			return {
				{ "╭", hl_name },
				{ "─", hl_name },
				{ "╮", hl_name },
				{ "│", hl_name },
				{ "╯", hl_name },
				{ "─", hl_name },
				{ "╰", hl_name },
				{ "│", hl_name },
			}
		end

		-- local types = require("cmp.types")
		-- local function deprioritize_snippet(entry1, entry2)
		-- 	if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
		-- 		return false
		-- 	end
		-- 	if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
		-- 		return true
		-- 	end
		-- end

		local cmp = require("cmp")
		local defaults = require("cmp.config.default")()

		return {
			preselect = cmp.PreselectMode.None,
			completion = {
				completeopt = "menu,menuone,noinsert,noselect",
			},
			snippet = {
				expand = function(args)
					require("snippy").expand_snippet(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.close(),
				["<cr>"] = cmp.mapping.confirm({
					select = false,
					behavior = cmp.ConfirmBehavior.Replace,
				}),
				["<C-a>"] = cmp.mapping(function(_)
					-- require("copilot.suggestion").accept()
					-- vim.api.nvim_feedkeys(vim.fn["codeium#Accept"](), "n", true)
				end),
				["<s-tab>"] = cmp.mapping.select_prev_item(),
				["<tab>"] = cmp.mapping.select_next_item(),
			}),
			sources = cmp.config.sources({
				{
					name = "nvim_lsp",
					priority = 5,
				},
				{ name = "path" },
				{ name = "nvim_lsp_signature_help" },
				{ name = "snippy", priority = 3 },
				{ name = "buffer", keywork_length = 3 },
				{ name = "npm", keyword_length = 4 },
				{ name = "rg", keyword_length = 4 },
			}),
			formatting = {
				format = function(_, vim_item)
					vim_item.kind = (lsp_symbols[vim_item.kind] or "") .. vim_item.kind
					return vim_item
				end,
			},
			experimental = {
				ghost_text = false,
			},
			sorting = defaults.sorting,
			-- sorting = {
			-- 	priority_weight = 2,
			-- 	comparators = {
			-- 		deprioritize_snippet,
			-- 		-- the rest of the comparators are pretty much the defaults
			-- 		cmp.config.compare.offset,
			-- 		cmp.config.compare.exact,
			-- 		cmp.config.compare.scopes,
			-- 		cmp.config.compare.score,
			-- 		cmp.config.compare.recently_used,
			-- 		cmp.config.compare.locality,
			-- 		cmp.config.compare.kind,
			-- 		cmp.config.compare.sort_text,
			-- 		cmp.config.compare.length,
			-- 		cmp.config.compare.order,
			-- 	},
			-- },
			confirm_opts = {
				behavior = cmp.ConfirmBehavior.Replace,
				select = false,
			},
			window = {
				completion = {
					border = border("CmpBorder"),
					winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
				},
				documentation = {
					border = border("CmpDocBorder"),
				},
			},
		}
	end,
}
