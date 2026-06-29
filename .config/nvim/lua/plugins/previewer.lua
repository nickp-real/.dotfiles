return {
  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = "cd app && yarn install",
    cmd = "MarkdownPreview",
  },

  -- LaTex
  {
    "lervag/vimtex",
    ft = "tex",
    init = function() vim.g.vimtex_view_method = "zathura" end,
  },
}
