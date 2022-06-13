-- local nullLs_diagnostic = { "pyright", "tsserver" }
local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local utils = require("lsp.utils")

local servers = { "bashls", "eslint" }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup({
    capabilities = utils.capabilities,
    on_attach = utils.on_attach,
    handlers = utils.handlers,
    flags = utils.flags,
  })
end

lspconfig.sumneko_lua.setup({
  capabilities = utils.capabilities,
  on_attach = function(client, bunfnr)
    require("lsp.servers.null-ls-format").on_attach(client, bunfnr)
  end,
  handlers = utils.handlers,
  flags = utils.flags,
  settings = require("lsp.servers.sumneko_lua").settings,
})

lspconfig.pyright.setup({
  capabilities = utils.capabilities,
  on_attach = function(client, bunfnr)
    require("lsp.servers.null-ls-format").on_attach(client, bunfnr)
  end,
  handlers = utils.handlers,
  flags = utils.flags,
})

lspconfig.tsserver.setup({
  capabilities = utils.capabilities,
  on_attach = function(client, bunfnr)
    require("lsp.servers.null-ls-format").on_attach(client, bunfnr)
  end,
  handlers = utils.handlers,
  flags = utils.flags,
})

lspconfig.cssls.setup({
  capabilities = utils.capabilities,
  on_attach = function(client, bunfnr)
    require("lsp.servers.null-ls-format").on_attach(client, bunfnr)
  end,
  handlers = utils.handlers,
  flags = utils.flags,
})

lspconfig.jsonls.setup({
  capabilities = utils.capabilities,
  on_attach = function(client, bunfnr)
    require("lsp.servers.null-ls-format").on_attach(client, bunfnr)
  end,
  handlers = utils.handlers,
  flags = utils.flags,
  settings = require("lsp.servers.jsonls").settings,
})

lspconfig.html.setup({
  capabilities = utils.capabilities,
  on_attach = function(client, bunfnr)
    require("lsp.servers.null-ls-format").on_attach(client, bunfnr)
  end,
  handlers = utils.handlers,
  flags = utils.flags,
})
