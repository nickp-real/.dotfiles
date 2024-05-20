local M = {}

local function filter(arr, fn)
  if type(arr) ~= "table" then return arr end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then table.insert(filtered, v) end
  end

  return filtered
end

local function filterReactDTS(value)
  -- Depending on typescript version either uri or targetUri is returned
  if value.uri then
    return string.match(value.uri, "%.d.ts") == nil
  elseif value.targetUri then
    return string.match(value.targetUri, "%.d.ts") == nil
  end
end

M.handlers = {
  ["textDocument/definition"] = function(err, result, method, ...)
    if vim.tbl_islist(result) and #result > 1 then
      local filtered_result = filter(result, filterReactDTS)
      return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
    end

    vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
  end,
}

M.on_attach = function(client, bufnr)
  local nnoremap = require("utils.keymap_utils").nnoremap
  nnoremap("gd", function() vim.cmd.TSToolsGoToSourceDefinition() end)

  require("tsc")
end

M.file_preferences = {
  includeInlayParameterNameHints = "all",
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayFunctionParameterTypeHints = false,
  includeInlayVariableTypeHints = false,
  includeInlayVariableTypeHintsWhenTypeMatchesName = true,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayFunctionLikeReturnTypeHints = false,
  includeInlayEnumMemberValueHints = true,
}

M.settings = {
  javascript = {
    inlayHints = M.file_preferences,
    format = { enable = false },
    completions = { completeFunctionCalls = true },
  },
  typescript = {
    inlayHints = M.file_preferences,
    format = { enable = false },
    completions = { completeFunctionCalls = true },
  },
  implicitProjectConfiguration = { checkJs = true },
}

M.before_format = function()
  vim.cmd.TSToolsRemoveUnusedImports()
  vim.cmd.TSToolsAddMissingImports()
  vim.cmd.TSToolsSortImports()
  vim.cmd.TSToolsOrganizeImports()
  vim.cmd.TSToolsFixAll()
end

M.is_ignore = true

return M
