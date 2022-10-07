local status_ok, lsp_inlayhints = pcall(require, "lsp-inlayhints")
if not status_ok then
  return
end

lsp_inlayhints.setup()
