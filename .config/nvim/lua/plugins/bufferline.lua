local M = {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
}

M.keys = {
  { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
  { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
  { "<leader><Tab>", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer Next" },
  { "<leader><S-Tab>", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer Prev" },
}

M.opts = {
  options = {
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    close_command = "Bdelete! %d",
    always_show_bufferline = false,
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
        text = "Neo Tree",
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
