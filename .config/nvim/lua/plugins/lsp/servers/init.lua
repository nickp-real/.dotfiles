local lspconfig = require("lspconfig")
local capabilities = require("plugins.lsp.config").capabilities
local servers = {}
local ignore_servers = { "tsserver" }

local M = {
  function(server_name)
    for _, v in pairs(ignore_servers) do
      if server_name == v then return end
    end

    local server = servers[server_name] or {}
    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
    lspconfig[server_name].setup(server)
  end,
}

servers.lua_ls = require("plugins.lsp.servers.lua_ls")
servers.pyright = require("plugins.lsp.servers.pyright")
servers.jsonls = require("plugins.lsp.servers.jsonls")
servers.yamlls = require("plugins.lsp.servers.yamlls")
servers.marksman = require("plugins.lsp.servers.marksman")
servers.svelte = require("plugins.lsp.servers.svelte")
servers.eslint = require("plugins.lsp.servers.eslint")
servers.tailwindcss = require("plugins.lsp.servers.tailwindcss")
servers.html = require("plugins.lsp.servers.html")
servers.cssls = require("plugins.lsp.servers.cssls")
servers.emmet = require("plugins.lsp.servers.emmet")
servers.volar = require("plugins.lsp.servers.volar")
servers.astro = require("plugins.lsp.servers.astro")

M.tsserver = function()
  local tsserver = require("plugins.lsp.servers.tsserver")
  require("typescript-tools").setup({
    on_attach = tsserver.on_attach,
    -- settings = require("lsp.servers.tsserver").settings,
    handlers = tsserver.handlers,
    single_file_support = true,
    settings = {
      -- spawn additional tsserver instance to calculate diagnostics on it
      separate_diagnostic_server = true,
      -- "change"|"insert_leave" determine when the client asks the server about diagnostic
      publish_diagnostic_on = "insert_leave",
      -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
      -- (see 💅 `styled-components` support section)
      tsserver_plugins = {},
      -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
      -- memory limit in megabytes or "auto"(basically no limit)
      tsserver_max_memory = "auto",
      -- described below
      tsserver_format_options = {},
      tsserver_file_preferences = tsserver.file_preferences,
      -- tsserver_path = tsserver_path .. "/node_modules/typescript/lib/tsserver.js",
      -- expose_as_code_action = "all",
      implicitProjectConfiguration = {
        checkJs = tsserver.settings.implicitProjectConfiguration.checkJs,
      },
    },
  })
end

return M
