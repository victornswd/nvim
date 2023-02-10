local namespace = vim.api.nvim_create_namespace("class_conceal")
local group = vim.api.nvim_create_augroup("class_conceal", { clear = true })

local tsxQuery = [[
	(
		jsx_attribute (property_identifier) @att_name (#match? @att_name "^class")
		(string (string_fragment) @attr_val) (#set! @attr_val conceal "…")
	)
]]
local htmlQuery = [[
	((attribute
			(attribute_name) @att_name (#eq? @att_name "class")
			(quoted_attribute_value (attribute_value) @class_value) (#set! @class_value conceal "…")))
]]

local conceal_html_class = function(bufnr, format)
	local language_tree = vim.treesitter.get_parser(bufnr, format)
	local syntax_tree = language_tree:parse()
	local root = syntax_tree[1]:root()

	local querySel = function()
		if format == "tsx" then
			return tsxQuery
		else
			if format == "html" then
				return htmlQuery
			end
		end
	end

	local query = vim.treesitter.parse_query(format, querySel()) -- using single character for conceal thanks to u/Rafat913

	for _, captures, metadata in query:iter_matches(root, bufnr, root:start(), root:end_()) do
		local start_row, start_col, end_row, end_col = captures[2]:range()
		vim.api.nvim_buf_set_extmark(bufnr, namespace, start_row, start_col, {
			end_line = end_row,
			end_col = end_col,
			conceal = metadata[2].conceal,
		})
	end
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "InsertLeave" }, {
	group = group,
	pattern = "*.html",
	callback = function()
		conceal_html_class(vim.api.nvim_get_current_buf(), "html")
	end,
})
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "TextChanged", "InsertLeave" }, {
	group = group,
	pattern = "*.tsx",
	callback = function()
		conceal_html_class(vim.api.nvim_get_current_buf(), "tsx")
	end,
})
