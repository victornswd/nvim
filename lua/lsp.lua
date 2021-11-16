local cmd = vim.cmd
local nvim_lsp = require 'lspconfig'
-- npm install -g diagnostic-languageserver eslint_d prettier_d_slim prettier
local function on_attach(client)
  print('Attached to ' .. client.name)
end
local dlsconfig = require 'diagnosticls-configs'
dlsconfig.init {
  default_config = false,
  format = true,
  on_attach = on_attach,
}
local eslint = require 'diagnosticls-configs.linters.eslint'
local prettier = require 'diagnosticls-configs.formatters.prettier'
prettier.requiredFiles = {
    '.prettierrc',
    '.prettierrc.json',
    '.prettierrc.toml',
    '.prettierrc.json',
    '.prettierrc.yml',
    '.prettierrc.yaml',
    '.prettierrc.json5',
    '.prettierrc.js',
    '.prettierrc.cjs',
    'prettier.config.js',
    'prettier.config.cjs',
  }
dlsconfig.setup {
  ['javascript'] = {
    linter = eslint,
    formatter = { prettier }
  },
  ['javascriptreact'] = {
    linter = { eslint },
    formatter = { prettier }
  },
  ['css'] = {
    formatter = prettier
  },
}
local lsp_symbols = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "ﰮ",
  Module = "",
  Property = "襁",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "﬌",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "ﬦ",
  TypeParameter = "",
}

cmd[[
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh    <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gca   <cmd>:Telescope lsp_code_actions<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gR    <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent><leader>fo <cmd>lua vim.lsp.buf.formatting()<CR>
]]

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
    local opts = {
      'bashls',
      'diagnosticls',
      'cssls',
      'eslint',
      'elmls',
      'emmet_ls',
      'graphql',
      'html',
      'jsonls',
      'tailwindcss',
      'tsserver',
      'vimls',
      'sumneko_lua'
  }
    --
    server:setup(opts)

    vim.cmd [[ do User LspAttachBuffers ]]

end)
-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = {
  'bashls',
  'diagnosticls',
  'cssls',
  'eslint',
  'elmls',
  'emmet_ls',
  'graphql',
  'html',
  'jsonls',
  'tailwindcss',
  'tsserver',
  'vimls',
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

nvim_lsp['sumneko_lua'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
}
-- Setup nvim-cmp.
local cmp = require'cmp'
local luasnip = require('luasnip')

cmp.setup({
  auto_select = false,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<cr>"] = cmp.mapping.confirm({select = true}),
    ["<s-tab>"] = cmp.mapping.select_prev_item(),
    ["<tab>"] = cmp.mapping.select_next_item(),
  },
  sources = {
    { name = 'nvim_lsp' },
    -- For vsnip user.
    -- { name = 'vsnip' },
    -- For luasnip user.
    { name = 'path' },
    -- For ultisnips user.
    -- { name = 'ultisnips' },
    { name = 'luasnip' },
    { name = 'buffer', keywork_length = 5 },
    { name = 'npm', keyword_length = 4 },
  },
  formatting = {
    format = function(entry, item)
      item.kind = lsp_symbols[item.kind]
      item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        -- neorg = "[Neorg]",
      })[entry.source.name]

      return item
    end,
    -- format = require('lspkind').cmp_format {
    --   with_text = true,
    --   menu = {
    --     buffer = "[buf]",
    --     nvim_lsp = "[LSP]",
    --     path = "[path]",
    --     luasnip = "[snip]"
    --   }
    -- }
  },
  experimental = {
    native_menu = false,
    ghost_text = true
  }
})

-- icon
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    -- This sets the spacing and the prefix, obviously.
    virtual_text = false
  }
)

local saga = require 'lspsaga'
saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
}