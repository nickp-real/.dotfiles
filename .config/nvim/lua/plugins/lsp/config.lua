local styles = require("core.styles")

local M = {}

local autoformat_setup = function()
  vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
      -- FormatDisable! will disable formatting just for this buffer
      vim.b.disable_autoformat = true
    else
      vim.g.disable_autoformat = true
    end
    require("utils").notify("Disabled format on save", "Format")
  end, {
    desc = "Disable autoformat-on-save",
    bang = true,
  })
  vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
    require("utils").notify("Enabled format on save", "Format")
  end, {
    desc = "Re-enable autoformat-on-save",
  })
end

M.toggle_auto_format = function()
  if vim.g.disable_autoformat or vim.b.disable_autoformat then
    return "<cmd>FormatEnable<cr>"
  else
    return "<cmd>FormatDisable<cr>"
  end
end

local highlightSetup = function(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", { clear = false })

    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      group = group,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved" }, {
      buffer = bufnr,
      group = group,
      callback = function() vim.lsp.buf.clear_references() end,
    })
  end
end

local mapping = function(bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local nnoremap = require("utils.keymap_utils").nnoremap

  local map = function(keys, func, desc) nnoremap(keys, func, { silent = true, buffer = bufnr, desc = "LSP:" .. desc }) end

  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

  map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]ifinition")
  map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
  map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
  map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
  map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
  map("K", vim.lsp.buf.hover, "Hover Documentation")
  map("gK", vim.lsp.buf.signature_help, "[G]oto (K hover but signature)")
  map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
  map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
end

M.attach = function()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LspConfig", { clear = false }),
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      assert(client ~= nil)

      -- client.server_capabilities.documentFormattingProvider = false
      -- client.server_capabilities.documentRangeFormattingProvider = false

      mapping(bufnr)
      autoformat_setup()
      highlightSetup(client, bufnr)

      if client.server_capabilities.documentSymbolProvider then require("nvim-navic").attach(client, bufnr) end

      require("lsp-inlayhints").on_attach(client, bufnr)
    end,
  })
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = vim.tbl_deep_extend("force", M.capabilities, require("cmp_nvim_lsp").default_capabilities())
M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
-- M.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true -- NOTE: remove when 0.10

M.flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 150,
}

M.default = {
  capabilities = M.capabilities,
  flags = M.flags,
}

M.signs = { Error = "󰅙 ", Warn = " ", Hint = "󰌵 ", Info = "󰋼 " }

M.diagnostic_config = {
  update_in_insert = false,
  virtual_text = { prefix = "", spacing = 4 },
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = styles.border,
    source = "always",
  },
  on_init_callback = function(_) M.setup_codelens_refresh(_) end,
}

function M.setup_codelens_refresh(client, bufnr)
  local status_ok, codelens_supported = pcall(function() return client.supports_method("textDocument/codeLens") end)

  if not status_ok or not codelens_supported then return end

  local group = "LSP CodeLens Refersh"
  local cl_event = { "BufEnter", "CursorHold", "InsertLeave" }
  local ok, cl_autocmds = pcall(vim.api.nvim_get_autocmds, { group = group, buffer = bufnr, event = cl_event })

  if ok and cl_autocmds > 0 then return end
  vim.api.nvim_create_augroup(group, { clear = false })
  vim.api.nvim_create_autocmd(cl_event, {
    group = group,
    buffer = bufnr,
    callback = function() vim.lsp.codelens.refresh() end,
  })
end

function M.setup()
  M.attach()

  local register_capability = vim.lsp.handlers["client/registerCapability"]

  vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
    local handler = register_capability(err, res, ctx)
    -- local client_id = ctx.client_id
    -- local client = vim.lsp.get_client_by_id(client_id)
    local buf = vim.api.nvim_get_current_buf()
    mapping(buf)
    return handler
  end

  for type, icon in pairs(M.signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  vim.diagnostic.config(M.diagnostic_config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = styles.border,
    silent = true,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = styles.border,
  })
end

return M
