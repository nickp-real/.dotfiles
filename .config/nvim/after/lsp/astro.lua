local M = {}

M.settings = {
  typescript = {
    preferences = { importModuleSpecifier = "non-relative" },
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

return M
