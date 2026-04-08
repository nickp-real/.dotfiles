local M = {}

M.on_attach = function(client, bufnr) end

M.settings = {
  tailwindCSS = {
    emmetCompletions = true,
    classFunctions = { "cva", "cn", "cx", "clsx" },
  },
}

return M
