local M = {}

M.settings = {
  svelte = {
    ["enable-ts-plugin"] = true,
  },
}

M.on_attach = function(client, bufnr)
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.js", "*.ts" },
    callback = function(ctx) client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file }) end,
  })
end

M.capabilities = {
  workspace = { didChangeWatchedFiles = { dynamicRegistration = true } },
}

return M
