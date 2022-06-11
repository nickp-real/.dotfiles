local status_ok, null_ls = pcall(require, "null-ls")
if not status_ok then
  return
end

local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics

local sources = {
  formatting.stylua,
  formatting.black,
  formatting.prettierd,
  -- diagnostics.eslint_d,
}

null_ls.setup({
  sources = sources,
  on_attach = function(client, bufnr)
    if client.resolved_capabilities.document_formatting then
      local group = vim.api.nvim_create_augroup("null_ls Format", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        -- buffer = bufnr,
        callback = function()
          vim.lsp.buf.formatting_sync()
        end,
        group = group,
      })
    end
  end,
  update_in_insert = false,
  debounce = 150,
})
