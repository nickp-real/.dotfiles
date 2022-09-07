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
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float({border = 'rounded'})<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({border = 'rounded'})<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next({border = 'rounded'})<CR>", opts)
  buf_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  -- buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  -- buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  -- buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
end

local on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  lsp_mapping(bufnr)

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  if client.resolved_capabilities.document_formatting then
    auto_format(client)
  end

  if client.server_capabilities.colorProvider then
    doc_color.buf_attach(bufnr, { mode = "background" })
  end
end

local no_format_on_attach = function(client, bufnr)
  client.resolved_capabilities.document_formatting = false
  client.resolved_capabilities.document_range_formatting = false
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
