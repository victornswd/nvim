local ok, _ = pcall(require, "bufdel")

if not ok then
  return
end

vim.cmd([[
:cnoreabbrev wq w ++p<bar>BufDel
:cnoreabbrev q BufDel
]])
