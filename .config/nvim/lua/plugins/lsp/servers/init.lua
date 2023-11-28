local lspconfig = require("lspconfig")
local root_pattern = require("lspconfig.util").root_pattern

local M = {
  function(server_name) lspconfig[server_name].setup({}) end,
}

M.lua_ls = function()
  local lua_ls = require("plugins.lsp.servers.lua_ls")
  lspconfig.lua_ls.setup({
    settings = lua_ls.settings,
  })
end

M.pyright = function()
  local pyright = require("plugins.lsp.servers.pyright")
  lspconfig.pyright.setup({
    settings = pyright.settings,
  })
end

M.jsonls = function()
  local jsonls = require("plugins.lsp.servers.jsonls")
  lspconfig.jsonls.setup({
    on_new_config = jsonls.on_new_config,
  })
end

M.yamlls = function()
  local yamlls = require("plugins.lsp.servers.yamlls")
  lspconfig.yamlls.setup({
    on_new_config = yamlls.on_new_config,
    settings = yamlls.settings,
  })
end

M.marksman = function()
  local marksman = require("plugins.lsp.servers.marksman")
  lspconfig.marksman.setup({
    filetypes = marksman.filetypes,
  })
end

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
    },
  })
end

M.svelte = function()
  local svelte = require("plugins.lsp.servers.svelte")
  lspconfig.svelte.setup({
    settings = svelte.settings,
  })
end

M.eslint = function()
  local eslint = require("plugins.lsp.servers.eslint")
  lspconfig.eslint.setup({
    on_attach = eslint.on_attach,
    settings = eslint.settings,
  })
end

M.tailwindcss = function()
  local tailwindcss = require("plugins.lsp.servers.tailwindcss")
  lspconfig.tailwindcss.setup({
    on_attach = tailwindcss.on_attach,
    init_options = tailwindcss.options,
    settings = tailwindcss.settings,
    root_dir = root_pattern(unpack(tailwindcss.root_dir)),
  })
end

M.html = function()
  local html = require("plugins.lsp.servers.html")
  lspconfig.html.setup({
    filetypes = html.filetypes,
    settings = html.settings,
  })
end

M.cssls = function()
  local cssls = require("plugins.lsp.servers.cssls")
  lspconfig.cssls.setup({
    settings = cssls.settings,
  })
end

M.volar = function()
  local volar = require("plugins.lsp.servers.volar")
  lspconfig.volar.setup({
    init_options = volar.init_options,
  })
end

return M
