local M = {}

M.settings = {
  svelte = {
    ["enable-ts-plugin"] = true,
  },
}

M.on_attach = function(client, bufnr) end

M.capabilities = {
  workspace = { didChangeWatchedFiles = { dynamicRegistration = true } },
}

return M
