local navic = require("nvim-navic")

local i, _ = string.find(vim.g.theme, "-NvChad")
if i then
  local base16 = require("base46").get_theme_tb("base_16")
  local colors = require("base46").get_theme_tb("base_30")

  vim.api.nvim_set_hl(0, "NavicIconsFile", { fg = base16.base07 })
  vim.api.nvim_set_hl(0, "NavicIconsModule", { fg = base16.base0A })
  -- vim.api.nvim_set_hl(0, 'NavicIconsNamespace', { fg = '#ffffff' })
  -- vim.api.nvim_set_hl(0, 'NavicIconsPackage', { fg = '#ffffff' })
  -- vim.api.nvim_set_hl(0, 'NavicIconsClass', { fg = '#ffffff' })
  vim.api.nvim_set_hl(0, "NavicIconsMethod", { fg = base16.base0D })
  vim.api.nvim_set_hl(0, "NavicIconsProperty", { fg = base16.base08 })
  vim.api.nvim_set_hl(0, "NavicIconsField", { fg = base16.base08 })
  vim.api.nvim_set_hl(0, "NavicIconsConstructor", { fg = colors.blue })
  -- vim.api.nvim_set_hl(0, 'NavicIconsEnum', { fg = '#ffffff' })
  -- vim.api.nvim_set_hl(0, 'NavicIconsInterface', { fg = '#ffffff' })
  vim.api.nvim_set_hl(0, "NavicIconsFunction", { fg = base16.base0D })
  vim.api.nvim_set_hl(0, "NavicIconsVariable", { fg = base16.base0E })
  vim.api.nvim_set_hl(0, "NavicIconsConstant", { fg = base16.base09 })
  -- vim.api.nvim_set_hl(0, 'NavicIconsString', { fg = '#ffffff' })
  -- vim.api.nvim_set_hl(0, 'NavicIconsNumber', { fg = '#ffffff' })
  -- vim.api.nvim_set_hl(0, 'NavicIconsBoolean', { fg = '#ffffff' })
  -- vim.api.nvim_set_hl(0, 'NavicIconsArray', { fg = '#ffffff' })
  -- vim.api.nvim_set_hl(0, 'NavicIconsObject', { fg = '#ffffff' })
  vim.api.nvim_set_hl(0, "NavicIconsKey", { fg = base16.base07 })
  -- vim.api.nvim_set_hl(0, 'NavicIconsNull', { fg = '#ffffff' })
  -- vim.api.nvim_set_hl(0, 'NavicIconsEnumMember', { fg = '#ffffff' })
  vim.api.nvim_set_hl(0, "NavicIconsStruct", { fg = base16.base0E })
  -- vim.api.nvim_set_hl(0, 'NavicIconsEvent', { fg = '#ffffff' })
  vim.api.nvim_set_hl(0, "NavicIconsOperator", { fg = base16.base05 })
  vim.api.nvim_set_hl(0, "NavicIconsTypeParameter", { fg = base16.base08 })
  -- vim.api.nvim_set_hl(0, 'NavicText', { bold = true, fg = colors.baby_pink })
  vim.api.nvim_set_hl(0, "NavicText", { bold = true, fg = colors.base05 })
  -- vim.api.nvim_set_hl(0, 'NavicText', { bold = true })
end

navic.setup({
  icons = {
    File = " ",
    Module = " ",
    Namespace = " ",
    Package = " ",
    Class = " ",
    Method = " ",
    Property = " ",
    Field = " ",
    Constructor = " ",
    Enum = "練",
    Interface = "練",
    Function = " ",
    Variable = " ",
    Constant = " ",
    String = " ",
    Number = " ",
    Boolean = "◩ ",
    Array = " ",
    Object = " ",
    Key = " ",
    Null = "ﳠ ",
    EnumMember = " ",
    Struct = " ",
    Event = " ",
    Operator = " ",
    TypeParameter = " ",
  },
  highlight = true,
  separator = " > ",
  depth_limit = 0,
  depth_limit_indicator = "..",
})
