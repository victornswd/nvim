require("dap-vscode-js").setup({
  -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  -- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
  adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript" }) do
  require("dap").configurations[language] = {
    {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    },
    {
      {
        type = "pwa-node",
        request = "launch",
        name = "Debug Jest Tests",
        -- trace = true, -- include debugger info
        runtimeExecutable = "node",
        runtimeArgs = {
          "./node_modules/jest/bin/jest.js",
          "--runInBand",
        },
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        console = "integratedTerminal",
        internalConsoleOptions = "neverOpen",
      },
    },
  }
end
require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
})

vim.keymap.set("n", "<Leader>db", ':lua require("dapui").toggle()<CR>', { silent = true, desc = "Toggle DAP UI" })
vim.keymap.set("n", "<F5>", ':lua require"dap".continue()<CR>', { silent = true, desc = "DAP Continue" })
vim.keymap.set("n", "<F10>", ':lua require"dap".step_over()<CR>', { silent = true, desc = "DAP Step Over" })
vim.keymap.set("n", "<F11>", ':lua require"dap".step_into()<CR>', { silent = true, desc = "DAP Step OInto" })
vim.keymap.set("n", "<F12>", ':lua require"dap".step_out()<CR>', { silent = true, desc = "DAP Step Out" })
vim.keymap.set(
  "n",
  "<Leader>b",
  ':lua require"dap".toggle_breakpoint()<CR>',
  { silent = true, desc = "DAP Toggle Breakpoint" }
)
vim.keymap.set(
  "n",
  "<Leader>B",
  ':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>',
  { silent = true, desc = "DAP Set Breakpoint" }
)
vim.keymap.set(
  "n",
  "<Leader>lp",
  ':lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>',
  { silent = true, desc = "DAP Set Breakpoint w/ Log Point" }
)
vim.keymap.set("n", "<Leader>dr", ':lua require"dap".repl.open()<CR>', { silent = true, desc = "DAP Open REPL" })
vim.keymap.set("n", "<Leader>dl", ':lua require"dap".run_last()<CR>', { silent = true, desc = "DAP Run Last" })
