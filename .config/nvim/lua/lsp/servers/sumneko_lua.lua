local M = {}
local utils = require("lsp.utils")

M.on_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
  utils.on_attach(client, bufnr)
end

M.settings = {
  Lua = {
    runtime = {
      version = "LuaJIT",
    },
    diagnostics = {
      globals = { "vim", "use" },
    },
  },
}

return M
