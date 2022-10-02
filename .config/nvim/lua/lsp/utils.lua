local M = {}

-- addon
local doc_color_status_ok, doc_color = pcall(require, "document-color")
local lsp_format_ok, lsp_format = pcall(require, "lsp-format")
if not lsp_format_ok then
  return
end

lsp_format.setup()
local auto_format = function(client)
  lsp_format.on_attach(client)
end

if not doc_color_status_ok then
  return
end

local lsp_mapping = function(bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  -- vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  -- vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  -- vim.keymap.set("n", "<space>wl", function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, bufopts)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<space>f", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
end

local on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  lsp_mapping(bufnr)

  if client.supports_method("textDocument/formatting") then
    auto_format(client)
  end

  if client.server_capabilities.colorProvider then
    doc_color.buf_attach(bufnr, { mode = "background" })
  end
end

local no_format_on_attach = function(client, bufnr)
  client.server_capabilities.document_formatting = false
  client.server_capabilities.document_range_formatting = false
  on_attach(client, bufnr)
end

local flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 150,
}

M.on_attach = on_attach
M.lsp_mapping = lsp_mapping
M.auto_format = auto_format
M.no_format_on_attach = no_format_on_attach

M.flags = flags

return M

-- Deprecated
-- M.custom_diagnostic_hide = function(bufnr)
--   local diag_group = vim.api.nvim_create_augroup("null-ls diagnostics", { clear = false })
--   vim.api.nvim_create_autocmd("InsertCharPre", {
--     buffer = bufnr,
--     callback = function()
--       vim.diagnostic.hide(nil, bufnr)
--     end,
--     group = diag_group,
--   })
--   vim.api.nvim_create_autocmd("InsertLeavePre", {
--     buffer = bufnr,
--     callback = function()
--       vim.diagnostic.show(nil, bufnr)
--     end,
--     group = diag_group,
--   })
-- end
