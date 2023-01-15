local M = {
  "numToStr/Comment.nvim",
  keys = { { "gc", mode = { "n", "x" } }, { "gb", mode = { "n", "x" } } },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
}

function M.config(_, opts)
  require("Comment").setup(opts)
end

function M.opts()
  return {
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    ignore = "^$",
    toggler = {
      ---Line-comment toggle keymap
      line = "gcc",
      ---Block-comment toggle keymap
      block = "gbc",
    },
  }
end

return M
