local M = {}

M.on_attach = function(client, bufnr) end

M.settings = {
  Lua = {
    diagnostics = {
      globals = { "vim", "use", "packer_plugins" },
    },
    hint = {
      enable = true,
      setType = true,
    },
    type = {
      castNumberToInteger = true,
      inferParamType = true,
    },
    completion = {
      callSnippet = "Replace",
    },
  },
}

return M
