local lspconfig = require("lspconfig")
local capabilities = require("plugins.lsp.config").capabilities

local server_config_path = "plugins.lsp.servers."

local get_server_config = function(server_name)
  local has_config, server_config = pcall(require, server_config_path .. server_name)

  if not has_config then return {} end

  server_config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server_config.capabilities or {})
  return server_config
end

local M = {
  function(server_name)
    local server_config = get_server_config(server_name)
    local is_ignore = server_config.is_ignore or false

    if is_ignore then return end

    lspconfig[server_name].setup(server_config)
  end,
}

return M
