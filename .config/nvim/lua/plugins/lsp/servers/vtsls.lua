local M = {}

M.on_attach = function(client, bufnr)
  -- local nnoremap = require("utils.keymap_utils").nnoremap
  -- nnoremap("gd", function() vim.cmd.TSToolsGoToSourceDefinition() end)

  require("tsc")
end

M.filetypes = {
  "javascript",
  "javascriptreact",
  "javascript.jsx",
  "typescript",
  "typescriptreact",
  "typescript.tsx",
}

M.settings = {
  complete_function_calls = true,
  vtsls = {
    enableMoveToFileCodeAction = true,
    autoUseWorkspaceTsdk = true,
    experimental = {
      completion = {
        enableServerSideFuzzyMatch = true,
      },
    },
  },
  typescript = {
    updateImportsOnFileMove = { enabled = "always" },
    suggest = { completeFunctionCalls = true },
    inlayHints = {
      enumMemberValues = { enabled = true },
      functionLikeReturnTypes = { enabled = false },
      parameterNames = { enabled = "literals" },
      parameterTypes = { enabled = false },
      propertyDeclarationTypes = { enabled = true },
      variableTypes = { enabled = false },
    },
  },
}

M.settings.javascript = M.settings.typescript

return M
