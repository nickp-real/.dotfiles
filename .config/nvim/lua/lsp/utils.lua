local M = {}

M.auto_format = function(client, bufnr)
  local group = vim.api.nvim_create_augroup("Format On Save", { clear = false })
  vim.api.nvim_create_autocmd("BufWritePre", {
    desc = client.name,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end,
    group = group,
  })
end

M.lsp_mapping = function(bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { silent = true, buffer = bufnr }
  local nnoremap = require("utils.keymap_utils").nnoremap

  local function diagnostic_goto(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
      go({ severity = severity })
    end
  end

  nnoremap("gD", vim.lsp.buf.declaration, bufopts)
  nnoremap("gd", vim.lsp.buf.definition, bufopts)
  nnoremap("K", vim.lsp.buf.hover, bufopts)
  nnoremap("gi", vim.lsp.buf.implementation, bufopts)
  nnoremap("<C-k>", vim.lsp.buf.signature_help, bufopts)
  nnoremap("<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
  nnoremap("<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
  nnoremap("<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  nnoremap("<space>D", vim.lsp.buf.type_definition, bufopts)
  nnoremap("<space>rn", vim.lsp.buf.rename, bufopts)
  nnoremap("<space>ca", vim.lsp.buf.code_action, bufopts)
  nnoremap("gr", vim.lsp.buf.references, bufopts)
  nnoremap("<space>f", function()
    vim.lsp.buf.format({ bufnr = bufnr })
  end, bufopts)
  nnoremap("]e", diagnostic_goto(true, "ERROR"), bufopts)
  nnoremap("[e", diagnostic_goto(false, "ERROR"), bufopts)
  nnoremap("]w", diagnostic_goto(true, "WARN"), bufopts)
  nnoremap("[w", diagnostic_goto(false, "WARN"), bufopts)
  nnoremap("[d", diagnostic_goto(false), bufopts)
  nnoremap("]d", diagnostic_goto(true), bufopts)
  nnoremap("<space>e", vim.diagnostic.open_float, bufopts)
  nnoremap("<C-q>", vim.diagnostic.setloclist, bufopts)
end

M.on_attach = function(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  M.lsp_mapping(bufnr)

  if client.server_capabilities.documentFormattingProvider then
    M.auto_format(client, bufnr)
  end

  if client.server_capabilities.documentHighlightProvider then
    local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      group = group,
      callback = function()
        vim.lsp.buf.document_highlight()
      end,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved" }, {
      buffer = bufnr,
      group = group,
      callback = function()
        vim.lsp.buf.clear_references()
      end,
    })
  end

  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end

  require("lsp-inlayhints").on_attach(client, bufnr)
end

M.no_format_on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  M.on_attach(client, bufnr)
end

M.capabilities = require("cmp_nvim_lsp").default_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

M.flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 150,
}

return M
