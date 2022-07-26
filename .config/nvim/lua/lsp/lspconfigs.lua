-- local nullLs_diagnostic = { "pyright", "tsserver" }
local lsp_config_status_ok, lspconfig = pcall(require, "lspconfig")
local lsp_installer_status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not (lsp_config_status_ok and lsp_installer_status_ok) then
  return
end

local utils = require("lsp.utils")
local root_pattern = require("lspconfig.util").root_pattern

lsp_installer.setup()

-- normal setting
local servers = { "bashls", "clangd" }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup({
    capabilities = utils.capabilities,
    on_attach = utils.on_attach,
    flags = utils.flags,
  })
end

-- custom format
local no_format_servers = { "html", "gopls" }
for _, lsp in pairs(no_format_servers) do
  lspconfig[lsp].setup({
    capabilities = utils.capabilities,
    on_attach = utils.no_format_on_attach,
    flags = utils.flags,
  })
end

-- typescript lsp
local typescript_ok, typescript = pcall(require, "typescript")
if typescript_ok then
  typescript.setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    -- LSP Config options
    server = {
      capabilities = require("lsp.servers.tsserver").capabilities,
      handlers = { ["textDocument/publishDiagnostics"] = function(...) end },
      on_attach = require("lsp.servers.tsserver").on_attach,
      flags = utils.flags,
    },
  })
end

lspconfig.sumneko_lua.setup({
  capabilities = utils.capabilities,
  on_attach = utils.no_format_on_attach,
  flags = utils.flags,
  settings = require("lsp.servers.sumneko_lua").settings,
})

lspconfig.pyright.setup({
  capabilities = utils.capabilities,
  on_attach = utils.no_format_on_attach,
  flags = utils.flags,
  settings = require("lsp.servers.pyright").settings,
})

lspconfig.jsonls.setup({
  capabilities = utils.capabilities,
  on_attach = utils.no_format_on_attach,
  flags = utils.flags,
  settings = require("lsp.servers.jsonls").settings,
})

lspconfig.tailwindcss.setup({
  capabilities = require("lsp.servers.tailwindcss").capabilities,
  filetypes = require("lsp.servers.tailwindcss").filetypes,
  init_options = require("lsp.servers.tailwindcss").init_options,
  on_attach = require("lsp.servers.tailwindcss").on_attach,
  settings = require("lsp.servers.tailwindcss").settings,
  root_dir = root_pattern(unpack(require("lsp.servers.tailwindcss").root_dir)),
})

lspconfig.cssls.setup({
  capabilities = utils.capabilities,
  on_attach = utils.no_format_on_attach,
  flags = utils.flags,
  settings = require("lsp.servers.cssls").settings,
})
