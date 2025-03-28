local M = {}
local nnoremap = require("utils.keymap_utils").nnoremap

local inlay_hint_setup = function(client, bufnr)
  local disabled_filetypes = { "TelescopePrompt" }
  if
    not client:supports_method("textDocument/inlayHint", bufnr)
    or not (vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buftype == "")
    or vim.tbl_contains(disabled_filetypes, vim.bo.ft)
  then
    return
  end
  vim.g.disable_inlay_hint = vim.g.disable_inlay_hint or false
  local mode = vim.api.nvim_get_mode().mode
  if not vim.g.disable_inlay_hint then vim.lsp.inlay_hint.enable(mode == "n" or mode == "v", { bufnr = bufnr }) end
  local group = vim.api.nvim_create_augroup("inlay_hint_on_normal", { clear = false })
  vim.api.nvim_create_autocmd("InsertEnter", {
    desc = "Disable inlay hint on insert",
    callback = function()
      if
        vim.g.disable_inlay_hint
        or not (vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buftype == "")
        or vim.tbl_contains(disabled_filetypes, vim.bo.ft)
      then
        return
      end
      vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
    end,
    group = group,
  })
  vim.api.nvim_create_autocmd("InsertLeave", {
    desc = "Enable inlay hint on insert",
    callback = function()
      if
        vim.g.disable_inlay_hint
        or not (vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buftype == "")
        or vim.tbl_contains(disabled_filetypes, vim.bo.ft)
      then
        return
      end
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end,
    group = group,
  })

  nnoremap("<leader>h", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
    vim.g.disable_inlay_hint = not vim.g.disable_inlay_hint
    if vim.g.disable_inlay_hint then
      require("snacks").notify.info("Disabled inlay hint", { title = "Inlay Hint" })
    else
      require("snacks").notify.info("Enabled inlay hint", { title = "Inlay Hint" })
    end
  end, { silent = true, buffer = bufnr, desc = "LSP: Toggle inlay [H]int" })
end

local mapping = function(bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local map = function(keys, func, desc) nnoremap(keys, func, { silent = true, buffer = bufnr, desc = "LSP: " .. desc }) end

  map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  map("gd", function() require("snacks").picker.lsp_definitions() end, "[G]oto [D]ifinition")
  map("grr", function() require("snacks").picker.lsp_references() end, "[G]oto [R]eferences")
  map("gri", function() require("snacks").picker.lsp_implementations() end, "[G]oto [I]mplementation")
  map("<leader>D", function() require("snacks").picker.lsp_type_definitions() end, "Type [D]efinition")
  map(
    "<leader>ds",
    function()
      require("snacks").picker.lsp_symbols({
        layout = { preset = "dropdown", preview = "main" },
      })
    end,
    "[D]ocument [S]ymbols"
  )
  map("<leader>ws", function() require("snacks").picker.lsp_workspace_symbols() end, "[W]orkspace [S]ymbols")
end

M.on_attach = function()
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_config", { clear = false }),
    callback = function(event)
      local bufnr = event.buf
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      assert(client ~= nil)

      -- client.server_capabilities.documentFormattingProvider = false
      -- client.server_capabilities.documentRangeFormattingProvider = false
      vim.diagnostic.config(M.diagnostic_config, vim.lsp.diagnostic.get_namespace(client.id))

      mapping(bufnr)

      inlay_hint_setup(client, bufnr)
      if client:supports_method("textDocument/documentSymbol", bufnr) then
        require("nvim-navic").attach(client, bufnr)
      end
      if client:supports_method("textDocument/codeLens", bufnr) then
        local group = vim.api.nvim_create_augroup("lsp_codelens_refresh", { clear = false })
        vim.lsp.codelens.refresh({ bufnr = bufnr })
        vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
          desc = "Refresh codelens",
          buffer = bufnr,
          callback = function() vim.lsp.codelens.refresh({ bufnr = bufnr }) end,
          group = group,
        })
      end
    end,
  })
end

M.capabilities = {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
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

---@type vim.diagnostic.Opts
M.diagnostic_config = {
  update_in_insert = false,
  virtual_text = { prefix = "", spacing = 4 },
  severity_sort = true,
  signs = {
    linehl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
      [vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
      [vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
      [vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
    },
    text = {
      [vim.diagnostic.severity.ERROR] = M.signs.Error,
      [vim.diagnostic.severity.WARN] = M.signs.Warn,
      [vim.diagnostic.severity.HINT] = M.signs.Hint,
      [vim.diagnostic.severity.INFO] = M.signs.Info,
    },
  },
  float = {
    border = vim.g.border,
    source = true,
  },
}

function M.setup() M.on_attach() end

return M
