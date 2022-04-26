vim.cmd([[packadd packer.nvim]])

local packer = nil
local function init()
  if packer == nil then
    packer = require('packer')
    packer.init({ disable_commands = true })
  end

  require('plugin-list')
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
