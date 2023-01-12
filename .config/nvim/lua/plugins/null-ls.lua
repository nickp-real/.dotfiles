local M = {
  "jose-elias-alvarez/null-ls.nvim",
  dependencies = { "mason.nvim" },
  event = "BufReadPre",
}

function M.opts()
  local null_ls = require("null-ls")

  local formatting = null_ls.builtins.formatting
  local diagnostics = null_ls.builtins.diagnostics
  local code_actions = null_ls.builtins.code_actions

  local sources = {
    ----------------
    -- Formatting --
    ----------------

    -- lua
    formatting.stylua,

    -- python
    formatting.black.with({ extra_args = { "--fast" } }),

    -- front-end
    -- formatting.prettierd.with({
    --   env = {
    --     PRETTIERD_LOCAL_PRETTIER_ONLY = 1,
    --   },
    -- }),
    formatting.prettierd,

    -- go
    formatting.golines,

    ----------------
    -- Diagnostic --
    ----------------

    -- front-end
    -- diagnostics.eslint_d.with({
    --   condition = function(utils)
    --     return utils.root_has_file({ ".eslintrc.json" })
    --   end,
    -- }),

    ------------------
    -- Code Actions --
    ------------------

    -- front-end
    -- code_actions.eslint_d.with({
    --   condition = function(utils)
    --     return utils.root_has_file({ ".eslintrc.json" })
    --   end,
    -- }),
    require("typescript.extensions.null-ls.code-actions"),
  }

  local utils = require("lsp.utils")

  return {
    sources = sources,
    on_attach = function(client, bufnr)
      if client.server_capabilities.documentFormattingProvider then
        utils.auto_format(client, bufnr)
      end
    end,
    update_in_insert = false,
    debounce = 150,
  }
end

return M
