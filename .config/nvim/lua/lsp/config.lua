local utils = require("lsp.utils")
local signs = utils.diagnostic_signs

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config(utils.diagnostic_config)
