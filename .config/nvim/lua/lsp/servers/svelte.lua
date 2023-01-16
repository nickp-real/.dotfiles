local M = {}

M.settings = {
  svelte = {
    ["enable-ts-plugin"] = true,
  },
}

M.on_attach = function(client, bufnr)
  require("lsp.utils").no_format_on_attach(client, bufnr)
end

return M
