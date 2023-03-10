local M = {}

local utils = require("lsp.utils")

M.on_attach = function(client, bufnr)
  utils.on_attach(client, bufnr)
  vim.api.nvim_create_autocmd("BufWritePre", { buffer = bufnr, command = "EslintFixAll" })
end

M.settings = {
  eslint = {
    autoFixOnSave = true,
    codeAction = {
      disableRuleComment = {
        enable = true,
        location = "separateLine",
      },
      showDocumentation = {
        enable = true,
      },
    },
    codeActionOnSave = {
      enable = false,
      mode = "all",
    },
    format = false,
    nodePath = "",
    onIgnoredFiles = "off",
    packageManager = "pnpm",
    quiet = false,
    rulesCustomizations = {},
    provideLintTask = true,
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectory = {
      mode = "location",
    },
  },
}

return M
