local M = {}

-- M.on_attach = function(client, bufnr)
--   -- vim.api.nvim_create_autocmd("BufWritePre", {
--   --   desc = "Eslint",
--   --   buffer = bufnr,
--   --   callback = function()
--   --     vim.cmd.EslintFixAll()
--   --   end,
--   --   group = utils.format_group(bufnr),
--   -- })
-- end
M.settings = {
  autoFixOnSave = true,
  workingDirectories = { mode = "auto" },
  codeActionOnSave = {
    enable = true,
    mode = "all",
  },
}

return M
