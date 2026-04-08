local M = {}

M.on_attach = function(client, bufnr) end

M.settings = {
  Lua = {
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
    codeLens = {
      enable = true,
    },
    runtime = {
      version = "LuaJIT",
    },
    workspace = {
      preloadFileSize = 10000,
      library = {
        vim.env.VIMRUNTIME,
      },
    },
  },
}

return M
