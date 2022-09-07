local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  return
end

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

local ft = require("Comment.ft")
ft.dart = { "//%s", "/*%s*/" }
