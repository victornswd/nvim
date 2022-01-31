require('bufferline').setup{
  options = {
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    show_buffer_close_icons = false,
    show_close_icon = false,
    max_prefix_length = 5,
  }
}
