require('lsp.installer')

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
}

vim.cmd[[
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gca   <cmd>:Telescope lsp_code_actions<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent><leader>fo <cmd>lua vim.lsp.buf.formatting()<CR>
]]

-- Setup nvim-cmp.
local cmp = require'cmp'
local luasnip = require('luasnip')
luasnip.snippets = {
	markdown = {}
}
luasnip.snippets.vimwiki = luasnip.snippets.markdown

require('luasnip.loaders.from_vscode').load({include = {'markdown'}})
require('luasnip.loaders.from_vscode').lazy_load()

local has_words_before = function()
  local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  auto_select = false,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<cr>"] = cmp.mapping.confirm({select = true}),
    -- ["<s-tab>"] = cmp.mapping.select_prev_item(),
    -- ["<tab>"] = cmp.mapping.select_next_item(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'luasnip' },
    { name = 'buffer', keywork_length = 5 },
    { name = 'npm', keyword_length = 4 },
    { name = 'rg', keyword_length = 4 },
  },
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = (lsp_symbols[vim_item.kind] or '') .. vim_item.kind
      return vim_item
    end,
  },
  experimental = {
    native_menu = false,
    ghost_text = true
  }
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- This sets the spacing and the prefix, obviously.
    virtual_text = false,
    update_in_insert = true,
  }
)

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
