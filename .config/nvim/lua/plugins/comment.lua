local M = {
  "numToStr/Comment.nvim",
  keys = { "gcc", "gbc", { "gc", mode = { "n", "x" } }, { "gb", mode = "x" } },
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
}

function M.config()
  local comment = require("Comment")

  comment.setup({
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    ignore = "^$",
    toggler = {
      ---Line-comment toggle keymap
      line = "gcc",
      ---Block-comment toggle keymap
      block = "gbc",
    },
  })
end

return M
