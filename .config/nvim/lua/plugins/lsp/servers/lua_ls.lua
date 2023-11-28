local M = {}

M.on_attach = function(client, bufnr) end

M.settings = {
  Lua = {
    runtime = {
      version = "LuaJIT",
    },
    diagnostics = {
      globals = { "vim", "use", "packer_plugins" },
    },
    hint = {
      enable = true,
      setType = true,
    },
    completion = {
      callSnippet = "Replace",
    },
  },
}

return M
