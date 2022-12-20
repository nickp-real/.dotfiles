local lsp_config_status_ok, lspconfig = pcall(require, "lspconfig")
local typescript_ok, typescript = pcall(require, "typescript")
local lsp_signature_ok, lsp_signature = pcall(require, "lsp_signature")
if not lsp_config_status_ok then
  return
end

local utils = require("lsp.utils")
local root_pattern = require("lspconfig.util").root_pattern

if lsp_signature_ok then
  local signature_config = {
    hint_enable = false,
  }
  lsp_signature.setup(signature_config)
end

local lsp_default = {
  capabilities = utils.capabilities,
  flags = utils.flags,
}

lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_default)

-- normal setting
local servers = { "bashls", "clangd", "taplo", "sqls", "marksman", "grammarly", "svelte" }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup({
    on_attach = utils.on_attach,
  })
end

-- custom format
local no_format_servers = { "gopls", "emmet_ls" }
for _, lsp in pairs(no_format_servers) do
  lspconfig[lsp].setup({
    on_attach = utils.no_format_on_attach,
  })
end

-- typescript lsp
if typescript_ok then
  typescript.setup({
    disable_commands = false, -- prevent the plugin from creating Vim commands
    debug = false, -- enable debug logging for commands
    -- LSP Config options
    server = {
      capabilities = require("lsp.servers.tsserver").capabilities,
      on_attach = require("lsp.servers.tsserver").on_attach,
      settings = require("lsp.servers.tsserver").settings,
      flags = utils.flags,
      handlers = require("lsp.servers.tsserver").handlers,
      single_file_support = true,
    },
  })
end

lspconfig.eslint.setup({
  on_attach = require("lsp.servers.eslint").on_attach,
  settings = require("lsp.servers.eslint").settings,
})

lspconfig.sumneko_lua.setup({
  on_attach = require("lsp.servers.sumneko_lua").on_attach,
  settings = require("lsp.servers.sumneko_lua").settings,
})

lspconfig.pyright.setup({
  on_attach = utils.no_format_on_attach,
  settings = require("lsp.servers.pyright").settings,
})

lspconfig.jsonls.setup({
  on_attach = utils.no_format_on_attach,
  settings = require("lsp.servers.jsonls").settings,
})

lspconfig.tailwindcss.setup({
  capabilities = require("lsp.servers.tailwindcss").capabilities,
  filetypes = require("lsp.servers.tailwindcss").filetypes,
  on_attach = utils.no_format_on_attach,
  init_options = require("lsp.servers.tailwindcss").init_options,
  settings = require("lsp.servers.tailwindcss").settings,
  root_dir = root_pattern(unpack(require("lsp.servers.tailwindcss").root_dir)),
})

lspconfig.html.setup({
  on_attach = utils.on_attach,
  settings = require("lsp.servers.html").settings,
})

lspconfig.cssls.setup({
  on_attach = utils.no_format_on_attach,
  settings = require("lsp.servers.cssls").settings,
})
