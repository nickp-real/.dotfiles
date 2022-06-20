-- local nullLs_diagnostic = { "pyright", "tsserver" }
local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local utils = require("lsp.utils")

-- stock format
local servers = { "bashls", "clangd" }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup({
    capabilities = utils.capabilities,
    on_attach = utils.on_attach,
    handlers = utils.handlers,
    flags = utils.flags,
  })
end

-- custom format
local no_format_servers = { "pyright", "cssls", "html", "tailwindcss" }
for _, lsp in pairs(no_format_servers) do
  lspconfig[lsp].setup({
    capabilities = utils.capabilities,
    on_attach = utils.no_format_on_attach,
    handlers = utils.handlers,
    flags = utils.flags,
  })
end

lspconfig.sumneko_lua.setup({
  capabilities = utils.capabilities,
  on_attach = utils.no_format_on_attach,
  handlers = utils.handlers,
  flags = utils.flags,
  settings = require("lsp.servers.sumneko_lua").settings,
})

lspconfig.tsserver.setup({
  capabilities = require("lsp.servers.tsserver").capabilities,
  on_attach = require("lsp.servers.tsserver").on_attach,
  handlers = utils.no_diagnostic_handler,
  flags = utils.flags,
  settings = require("lsp.servers.tsserver").settings,
})

lspconfig.jsonls.setup({
  capabilities = utils.capabilities,
  on_attach = utils.no_format_on_attach,
  handlers = utils.handlers,
  flags = utils.flags,
  settings = require("lsp.servers.jsonls").settings,
})

lspconfig.arduino_language_server.setup({
  capabilities = utils.capabilities,
  on_attach = utils.on_attach,
  handlers = utils.handlers,
  flags = utils.flags,
  on_new_config = require("lsp.servers.arduino_language_server").on_new_config,
})
