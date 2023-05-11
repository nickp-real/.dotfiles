local M = {}

M.signs = { Error = "󰅙 ", Warn = " ", Hint = "󰌵 ", Info = "󰋼 " }

M.diagnostic_config = {
  update_in_insert = false,
  virtual_text = true,
  signs = { active = M.signs },
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
  },
  on_init_callback = function(_)
    M.setup_codelens_refresh(_)
  end,
}

function M.setup_codelens_refresh(client, bufnr)
  local status_ok, codelens_supported = pcall(function()
    return client.supports_method("textDocument/codeLens")
  end)

  if not status_ok or not codelens_supported then
    return
  end

  local group = "LSP CodeLens Refersh"
  local cl_event = { "BufEnter", "InsertLeave" }
  local ok, cl_autocmds = pcall(vim.api.nvim_get_autocmds, { group = group, buffer = bufnr, event = cl_event })

  if ok and cl_autocmds > 0 then
    return
  end
  vim.api.nvim_create_augroup(group, { clear = false })
  vim.api.nvim_create_autocmd(cl_event, {
    group = group,
    buffer = bufnr,
    callback = function()
      vim.lsp.codelens.refresh()
    end,
  })
end

function M.setup()
  for type, icon in pairs(M.signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  vim.diagnostic.config(M.diagnostic_config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end

return M
