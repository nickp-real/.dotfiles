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

return M
