local M = {
  "akinsho/bufferline.nvim",
  event = "BufReadPre",
}

M.config = {
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
        filetype = "neo-tree",
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
}

return M
