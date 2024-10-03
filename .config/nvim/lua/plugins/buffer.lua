return {
  -- Better bd
  {
    "famiu/bufdelete.nvim",
    cmd = "Bdelete",
    keys = { { "<leader>q", "<cmd>Bdelete<cr>", desc = "Delete Buffer" } },
  },

  -- Auto delete buffer after {n} mins
  {
    "chrisgrieser/nvim-early-retirement",
    event = "VeryLazy",
    config = true,
  },
}
