local M = {}

M.settings = {
  -- svelte = {
  --   ["enable-ts-plugin"] = true,
  -- },
  typescript = {
    inlayHints = {
      enumMemberValues = { enabled = true },
      functionLikeReturnTypes = { enabled = false },
      parameterNames = { enabled = "all", suppressWhenArgumentMatchesName = false },
      parameterTypes = { enabled = false },
      propertyDeclarationTypes = { enabled = true },
      variableTypes = { enabled = false, suppressWhenTypeMatchesName = true },
    },
  },
}

M.on_attach = function(client, bufnr)
  -- vim.api.nvim_create_autocmd("BufWritePost", {
  --   pattern = { "*.js", "*.ts" },
  --   callback = function(ctx) client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match }) end,
  -- })
end

M.capabilities = {
  -- workspace = { didChangeWatchedFiles = { dynamicRegistration = true } },
  workspace = { didChangeWatchedFiles = false },
}

return M
