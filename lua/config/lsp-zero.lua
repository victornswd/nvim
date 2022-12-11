local lsp = require("lsp-zero")
lsp.preset("lsp-compe")

lsp.ensure_installed({
  "bashls",
  "cssls",
  "html",
  "jsonls", -- custom
  "tsserver", -- custom
  "tailwindcss", -- custom
  "prismals",
  "astro",
  "sqls",
  "emmet_ls",
  "sumneko_lua",
})

lsp.set_preferences({
  set_lsp_keymaps = false,
})

lsp.on_attach(function(_, bufnr)
  -- keymap
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "LSP - Go to declaration" })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "LSP - Go to definition" })
  vim.keymap.set("n", "gh", vim.lsp.buf.hover, { desc = "LSP - Display hover tooltip" })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "LSP - Go to implementation" })
  vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { desc = "LSP - Go to type definition" })
  vim.keymap.set("n", "gR", vim.lsp.buf.rename, { desc = "LSP - Rename all references" })
  vim.keymap.set("n", "gr", function()
    pcall(require("telescope.builtin").lsp_references)
  end, { desc = "LSP - References" })
  vim.keymap.set("n", "gca", vim.lsp.buf.code_action, { desc = "LSP - Code actions" })

  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "LSP - Function signature help" })

  require("lsp_signature").on_attach({
    floating_window = false,
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "rounded",
    },
  }, bufnr)
end)

lsp.configure("jsonls", require("config.lsp.servers.json").setup)
lsp.configure("tailwindcss", require("config.lsp.servers.tailwind").setup)
lsp.configure("tsserver", require("config.lsp.servers.typescript").setup)

require("config/cmp-conf")

lsp.nvim_workspace()
lsp.setup()

-- keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts, { desc = "LSP - Open Diag" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts, { desc = "LSP - Go to previous diag" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts, { desc = "LSP - Go to next diag" })
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts, { desc = "LSP - Add all diagnostics to loclist" })
