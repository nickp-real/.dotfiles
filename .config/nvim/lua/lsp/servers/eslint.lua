local M = {}

local utils = require("lsp.utils")

local on_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = true
  client.resolved_capabilities.document_range_formatting = true

  utils.on_attach(client, bufnr)
end

local settings = {
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
  format = true,
  nodePath = "",
  onIgnoredFiles = "off",
  packageManager = "pnpm",
  quiet = false,
  rulesCustomizations = {},
  run = "onType",
  useESLintClass = false,
  validate = "on",
  workingDirectory = {
    mode = "location",
  },
}

M.settings = settings
M.on_attach = on_attach

return M
