local M = {}

M.theme = "everforest-NvChad"

-- if theme given, load given theme if given, otherwise nvchad_theme
M.init = function(theme)
  if not theme then
    theme = M.theme
  end

  -- set the global theme, used at various places like theme switcher, highlights
  vim.g.theme = theme

  local present, base16 = pcall(require, 'base16')

  if present then
    -- first load the base16 theme
    -- base16(base16.themes(theme), true)
    vim.cmd('colorscheme ' .. theme)

    -- unload to force reload
    package.loaded['colors.highlights' or false] = nil
    -- then load the highlights
    require('colors.highlights')
  end
end

-- returns a table of colors for given or current theme
M.get = function(theme)
  if not theme then
    theme = vim.g.theme
  end

  local i, j = string.find(theme, '-NvChad')
  local th = theme
  if i then
    th = string.sub(theme, 1, (i - 1))
    return require('hl_themes.' .. th)
  end

  -- FIXME: deal with non-base16 themes (highlights, feline, indent-blankline)
  return false
end

M.reload_theme = function(theme)
  package.loaded['config.feline' or false] = nil
  package.loaded['config.indent-blankline' or false] = nil

  require('colors').init(theme)
  require('config.feline')
  require('config.indent-blankline')
end

return M
-- vim.g.rose_pine_variant = 'moon'
--
-- -- Load colorscheme after options
-- vim.cmd('colorscheme rose-pine')

-- require('mini.base16').setup({
--   palette = {
--     base00 = '#2b3339',
--     base01 = '#363e44',
--     base02 = '#4a5258',
--     base03 = '#5e666c',
--     base04 = '#e69875',
--     base05 = '#d1b171',
--     base06 = '#dbbc7f',
--     base07 = '#b4bbc8',
--     base08 = '#D3C6AA',
--     base09 = '#cc7e46',
--     base0A = '#83c092',
--     base0B = '#a7c080',
--     base0C = '#ff75a0',
--     base0D = '#69a59d',
--     base0E = '#d699b6',
--     base0F = '#95d1c9',
--   },
--   use_cterm = true,
-- })
