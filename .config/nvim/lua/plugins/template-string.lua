local status_ok, template_string = pcall(require, "template-string")
if not status_ok then
  return
end

template_string.setup()
