local conf = require('config.lsp.helpers')
local capabilities = conf.capabilities
capabilities.textDocument.colorProvider = { dynamicRegistration = false }

require('lspconfig').tailwindcss.setup({
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    if client.server_capabilities.colorProvider then
      require('config.lsp.documentcolors').buf_attach(bufnr)
    end
  end,
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = {
    'aspnetcorerazor',
    'astro',
    'astro-markdown',
    'blade',
    'django-html',
    'edge',
    'eelixir',
    'ejs',
    'erb',
    'eruby',
    'gohtml',
    'haml',
    'handlebars',
    'hbs',
    'html',
    'html-eex',
    'jade',
    'leaf',
    'liquid',
    'mdx',
    'mustache',
    'njk',
    'nunjucks',
    'php',
    'razor',
    'slim',
    'twig',
    'css',
    'less',
    'postcss',
    'sass',
    'scss',
    'stylus',
    'sugarss',
    'javascript',
    'javascriptreact',
    'reason',
    'rescript',
    'typescript',
    'typescriptreact',
    'vue',
    'svelte',
  },
  init_options = {
    userLanguages = {
      eelixir = 'html-eex',
      eruby = 'erb',
    },
  },
  on_new_config = function(new_config)
    if not new_config.settings then
      new_config.settings = {}
    end
    if not new_config.settings.editor then
      new_config.settings.editor = {}
    end
    if not new_config.settings.editor.tabSize then
      -- set tab size for hover
      new_config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
    end
  end,
  settings = {
    tailwindCSS = {
      lint = {
        cssConflict = 'warning',
        invalidApply = 'error',
        invalidConfigPath = 'error',
        invalidScreen = 'error',
        invalidTailwindDirective = 'error',
        invalidVariant = 'error',
        recommendedVariantOrder = 'warning',
      },
      experimental = {
        classRegex = {
          'tw`([^`]*)',
          'tw="([^"]*)',
          'tw={"([^"}]*)',
          'tw\\.\\w+`([^`]*)',
          'tw\\(.*?\\)`([^`]*)',
        },
      },
      validate = true,
    },
  },
})
