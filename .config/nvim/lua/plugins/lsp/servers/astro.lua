local mason_registry = require("mason-registry")
local tsserver_path = mason_registry.get_package("typescript-language-server"):get_install_path()

local M = {}

M.init_options = {
  typescript = { tsdk = tsserver_path .. "/node_modules/typescript/lib" },
}

return M
