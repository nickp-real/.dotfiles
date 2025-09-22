return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function(_, opts) require("rainbow-delimiters.setup").setup(opts) end,
    opts = { highlight = vim.g.indent_highlights },
  },

  -- Markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = { lsp = { enabled = true }, blink = { enabled = true } },
    },
  },

  -- Log Highlight
  { "MTDL9/vim-log-highlighting", ft = "log" },

  -- nui
  "MunifTanjim/nui.nvim",
}
