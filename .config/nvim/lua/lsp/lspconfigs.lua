local lsp_config_status_ok, lspconfig = pcall(require, "lspconfig")
local mason_status_ok, mason = pcall(require, "mason")
local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
local typescript_ok, typescript = pcall(require, "typescript")
local cmp_nvim_lsp_status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local lsp_signature_ok, lsp_signature = pcall(require, "lsp_signature")
if not (lsp_config_status_ok and mason_status_ok and mason_lsp_ok) then
  return
end

local utils = require("lsp.utils")
local root_pattern = require("lspconfig.util").root_pattern

mason.setup({
  ui = {
    icons = {
      package_installed = "",
      package_pending = "",
      package_uninstalled = "",
    },
  },
})

mason_lsp.setup({
  -- A list of servers to automatically install if they're not already installed
  ensure_installed = {
    "bashls",
    "cssls",
    "html",
    "jsonls",
    "sumneko_lua",
    "tailwindcss",
    "tsserver",
    "clangd",
    "gopls",
    "pyright",
  },

  -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
  -- This setting has no relation with the `ensure_installed` setting.
  -- Can either be:
  --   - false: Servers are not automatically installed.
  --   - true: All servers set up via lspconfig are automatically installed.
  --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
  --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
  automatic_installation = true,
})

if not (cmp_nvim_lsp_status_ok and lsp_signature_ok) then
  return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local signature_config = {
  hint_enable = false,
}

lsp_signature.setup(signature_config)

local lsp_default = {
  capabilities = capabilities,
  flags = utils.flags,
}

lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_default)

-- normal setting
local servers = { "bashls", "clangd", "taplo" }
for _, lsp in pairs(servers) do
  lspconfig[lsp].setup({
    on_attach = utils.on_attach,
  })
end

-- custom format
local no_format_servers = { "html", "gopls" }
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
    -- Shothand for non eslint (framework) dir and with eslint dir
    server = {
      capabilities = require("lsp.servers.tsserver").capabilities,
      on_attach = require("lsp.servers.tsserver").on_attach,
      settings = require("lsp.servers.tsserver").settings,
      flags = utils.flags,
      single_file_support = true,
    },
  })
end

lspconfig.eslint.setup({
  on_attach = require("lsp.servers.eslint").on_attach,
  settings = require("lsp.servers.eslint").settings,
})

lspconfig.sumneko_lua.setup({
  on_attach = utils.no_format_on_attach,
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

lspconfig.cssls.setup({
  on_attach = utils.no_format_on_attach,
  settings = require("lsp.servers.cssls").settings,
})
