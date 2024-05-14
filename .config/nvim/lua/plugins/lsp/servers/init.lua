local lspconfig = require("lspconfig")
local capabilities = require("plugins.lsp.config").capabilities
local servers = {}

local servers_path = vim.fn.stdpath("config") .. "/lua/plugins/lsp/servers"

-- get all the server configs
for filename, _ in vim.fs.dir(servers_path) do
  local name = vim.fn.fnamemodify(filename, ":r")
  if name ~= "init" then servers[name] = require("plugins.lsp.servers." .. name) end
end

local M = {
  function(server_name)
    local server = servers[server_name] or {}
    local is_ignore = server.is_ignore or false

    if is_ignore then return end

    server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
    lspconfig[server_name].setup(server)
  end,
}

M.tsserver = function()
  local tsserver = servers.tsserver
  require("typescript-tools").setup({
    on_attach = tsserver.on_attach,
    capabilities = capabilities,
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
