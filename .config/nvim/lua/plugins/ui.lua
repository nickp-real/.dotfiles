return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function(_, opts) require("rainbow-delimiters.setup").setup(opts) end,
    opts = { highlight = vim.g.indent_highlights },
  },

  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {
      hide_target_hack = true,
      never_draw_over_target = true,
      cursor_color = "none",
    },
  },

  -- Markdown
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
    ft = "markdown",
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      completions = { lsp = { enabled = true }, blink = { enabled = true } },
      overrides = { buftype = { nofile = { enabled = false } } },
    },
  },

  -- Log Highlight
  { "MTDL9/vim-log-highlighting", ft = "log" },

  -- nui
  "MunifTanjim/nui.nvim",
}
