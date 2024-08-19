return {
  {
    "garymjr/nvim-snippets",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = { friendly_snippets = true },
  },

  -- Description generator
  {
    "danymat/neogen",
    cmd = "Neogen",
    opts = { snippet_engine = "nvim" },
  },
}
