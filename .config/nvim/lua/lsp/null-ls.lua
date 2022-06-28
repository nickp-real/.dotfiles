local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

local utils = require("lsp.utils")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

local sources = {
  -- formatting
  formatting.stylua,
  formatting.black.with({
    extra_args = { "--fast" },
  }),
  formatting.prettierd,
  formatting.rustywind,

  -- diagnostic
  diagnostics.flake8,
  diagnostics.eslint_d,

  -- code actions
  code_actions.gitsigns,
  code_actions.eslint_d,
}

null_ls.setup({
  sources = sources,
  on_attach = function(client, bufnr)
    if client.resolved_capabilities.document_formatting then
      utils.auto_format(client)
    end
  end,
  update_in_insert = false,
  debounce = 150,
})
