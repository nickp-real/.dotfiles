local M = {}

M.auto_format_enable = true

M.toggle_auto_format = function()
  if vim.b.auto_format_enable == false then
    vim.b.auto_format_enable = nil
    M.auto_format_enable = true
  else
    M.auto_format_enable = not M.auto_format_enable
  end
  if M.auto_format_enable then
    require("utils").notify("Enabled format on save", "Format")
  else
    require("utils").notify("Disabled format on save", "Format")
  end
end

M.auto_format = function(client, bufnr)
  if
    client.config
    and client.config.capabilities
    and client.config.capabilities.documentFormattingProvider == false
  then
    return
  end

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      desc = client.name,
      buffer = bufnr,
      callback = function()
        if M.auto_format_enable then
          vim.lsp.buf.format({ bufnr = bufnr })
        end
      end,
      group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, {}),
    })
  end
end

M.lsp_mapping = function()
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local nnoremap = require("utils.keymap_utils").nnoremap
  local nvnoremap = require("utils.keymap_utils").nvnoremap

  local function diagnostic_goto(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
      go({ severity = severity })
    end
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      local bufnr = ev.buf
      local bufopts = { silent = true, buffer = bufnr }

      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

      nnoremap("gD", vim.lsp.buf.declaration, bufopts)
      nnoremap("gd", require("definition-or-references").definition_or_references, bufopts)
      nnoremap("<C-LeftMouse>", function()
        -- Simulate click to place cursor on correct position
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<LeftMouse>", false, false, true), "in", false)

        -- defer to let nvim refresh to get correct position
        vim.defer_fn(function()
          require("definition-or-references").definition_or_references()
        end, 0)
      end, bufopts)
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
      nvnoremap("<space>ca", vim.lsp.buf.code_action, bufopts)
      nnoremap("<space>f", function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end, bufopts)
      nnoremap("<space>fe", M.toggle_auto_format, bufopts)
      nnoremap("]e", diagnostic_goto(true, "ERROR"), bufopts)
      nnoremap("[e", diagnostic_goto(false, "ERROR"), bufopts)
      nnoremap("]w", diagnostic_goto(true, "WARN"), bufopts)
      nnoremap("[w", diagnostic_goto(false, "WARN"), bufopts)
      nnoremap("[d", diagnostic_goto(false), bufopts)
      nnoremap("]d", diagnostic_goto(true), bufopts)
      nnoremap("<space>e", vim.diagnostic.open_float, bufopts)
      nnoremap("<C-q>", vim.diagnostic.setloclist, bufopts)
    end,
  })
end

M.on_attach = function(client, bufnr)
  M.auto_format(client, bufnr)

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
