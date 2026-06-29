return {
  -- Git Signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    keys = {
      {
        "<leader>gb",
        function() require("gitsigns").blame_line({ full = true }) end,
        desc = "show current line blame",
      },
      {
        "]g",
        function() require("gitsigns").nav_hunk("next") end,
        desc = "Go to next git hunk",
      },
      {
        "[g",
        function() require("gitsigns").nav_hunk("prev") end,
        desc = "Go to previous git hunk",
      },
    },
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
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewRefresh" },
  },
}
