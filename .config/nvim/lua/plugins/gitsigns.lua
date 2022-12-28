local M = {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
}

M.config = {
  signs = {
    add = { text = "▌" },
    change = { text = "▌" },
    delete = { text = "▌" },
    topdelete = { text = "▌" },
    changedelete = { text = "▌" },
    untracked = { text = "▌" },
  },
  numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
  preview_config = { border = "rounded" },
  current_line_blame = true,
}

return M
