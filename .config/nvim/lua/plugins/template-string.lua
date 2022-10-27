local status_ok, template_string = pcall(require, "template-string")
if not status_ok then
  return
end

template_string.setup({
  remove_template_string = true, -- remove backticks when there are no template string
  restore_quotes = {
    -- quotes used when "remove_template_string" option is enabled
    normal = [["]],
    jsx = [["]],
  },
})
