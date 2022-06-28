-- local nullLs_diagnostic = { "pyright", "tsserver" }
local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local utils = require("lsp.utils")

-- stock format
local servers = { "bashls", "clangd", "gopls" }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup({
    capabilities = utils.capabilities,
    on_attach = utils.on_attach,
    handlers = utils.handlers,
    flags = utils.flags,
  })
end

-- custom format
local no_format_servers = { "cssls", "html" }
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

lspconfig.pyright.setup({
  capabilities = utils.capabilities,
  on_attach = require("lsp.servers.pyright").on_attach,
  handlers = utils.no_diagnostic_handler,
  flags = utils.flags,
})

lspconfig.tailwindcss.setup({
  capabilities = require("lsp.servers.tailwindcss").capabilities,
  filetypes = require("lsp.servers.tailwindcss").filetypes,
  handlers = utils.handlers,
  init_options = require("lsp.servers.tailwindcss").init_options,
  on_attach = require("lsp.servers.tailwindcss").on_attach,
  settings = require("lsp.servers.tailwindcss").settings,
})
