local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup({
  options = {
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    close_command = "Bdelete! %d",
    indicator = {
      icon = "▌",
      style = "icon",
    },
    offsets = {
      {
        filetype = "Outline",
        text = "Symbols Outline",
        highlight = "Directory",
        text_align = "center",
      },
      {
        filetype = "NvimTree",
        text = "Nvim Tree",
        highlight = "Directory",
        text_align = "center",
      },
    },
  },
  highlights = {
    indicator_selected = {
      fg = "#61afef",
    },
  },
})
