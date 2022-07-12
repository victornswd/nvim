local null_ls = require('null-ls')
local config = require('config.lsp.helpers')
local b = null_ls.builtins

local sources = {
  b.formatting.prettierd.with({
    filetypes = { 'html', 'markdown', 'css' },
    prefer_local = 'node_modules/.bin',
  }),
  b.formatting.deno_fmt,
  b.formatting.elm_format,

  -- Lua
  b.formatting.stylua,
  b.diagnostics.luacheck.with({ extra_args = { '--global vim' } }),

  -- Shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with({ diagnostics_format = '#{m} [#{c}]' }),
}

null_ls.setup({
  debug = true,
  sources = sources,

  -- format on save
  on_attach = config.on_attach,
})
