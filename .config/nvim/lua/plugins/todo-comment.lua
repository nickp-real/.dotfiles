local status_ok, todo_comment = pcall(require, "todo-comments")
if not status_ok then
  return
end

todo_comment.setup()
