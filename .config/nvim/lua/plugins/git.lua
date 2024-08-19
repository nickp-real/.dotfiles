return {
  -- Git Signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      signs = {
        add = { text = "▌" },
        change = { text = "▌" },
        delete = { text = "▌" },
        topdelete = { text = "▌" },
        changedelete = { text = "▌" },
        untracked = { text = "▌" },
      },
      preview_config = { border = vim.g.border },
      current_line_blame = true,
    },
  },

  { "akinsho/git-conflict.nvim", event = { "BufReadPost", "BufNewFile", "BufWritePre" }, config = true },
}
