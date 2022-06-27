local M = {}
local utils = require("lsp.utils")

M.on_attach = function(client, bufnr)
  utils.no_format_on_attach(client, bufnr)
  utils.custom_diagnostic_hide(bufnr)
end

return M
