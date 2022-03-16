local present, base16 = pcall(require, 'base16')

if present then
  -- NOTE: save the colorscheme name in the global space for easy access in highlights
  _G.cs = 'everforest-base16'
  vim.cmd('colorscheme ' .. cs)

  require('colors.highlights')
end

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
