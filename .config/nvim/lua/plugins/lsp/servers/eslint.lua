local M = {}

M.on_attach = function(client, bufnr)
  -- vim.api.nvim_create_autocmd("BufWritePre", {
  --   desc = "Eslint",
  --   buffer = bufnr,
  --   callback = function()
  --     vim.cmd.EslintFixAll()
  --   end,
  --   group = utils.format_group(bufnr),
  -- })
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
      enable = true,
      mode = "all",
    },
    format = { enable = false },
    nodePath = "",
    onIgnoredFiles = "off",
    packageManager = "pnpm",
    quiet = false,
    rulesCustomizations = {},
    provideLintTask = true,
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectory = { mode = "auto" },
  },
}

return M
