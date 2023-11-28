return {
  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = "cd app && yarn install",
    cmd = "MarkdownPreview",
  },

  -- HTML
  {
    "turbio/bracey.vim",
    ft = "html",
    build = "npm install --prefix server",
    init = function() vim.g.bracey_refresh_on_save = 1 end,
  },

  -- LaTex
  {
    "lervag/vimtex",
    ft = "tex",
    init = function() vim.g.vimtex_view_method = "zathura" end,
  },
}
