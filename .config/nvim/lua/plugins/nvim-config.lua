return {
  -- for nvim config
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "nvim-lspconfig", words = { "lspconfig" } },
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
