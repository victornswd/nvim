local present, base16 = pcall(require, "base16")
local theme = "everforest"

if present then
    -- first load the base16 theme
    base16(base16.themes(theme), true)

    -- unload to force reload
    -- package.loaded["colors.highlights" or false] = nil
    -- then load the highlights
    require "colors.highlights"
end

-- vim.g.rose_pine_variant = 'moon'
--
-- -- Load colorscheme after options
-- vim.cmd('colorscheme rose-pine')

