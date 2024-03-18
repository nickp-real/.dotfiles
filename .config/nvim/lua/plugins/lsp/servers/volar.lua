local M = {}

local lsp_conficts, _ = pcall(vim.api.nvim_get_autocmds, { group = "LspAttach_conflicts" })
if not lsp_conficts then vim.api.nvim_create_augroup("LspAttach_conflicts", {}) end
vim.api.nvim_create_autocmd("LspAttach", {
  group = "LspAttach_conflicts",
  desc = "prevent tsserver and volar competing",
  callback = function(args)
    if not (args.data and args.data.client_id) then return end
    local active_clients = vim.lsp.get_active_clients()
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- prevent tsserver and volar competing
    -- if client.name == "volar" or require("lspconfig").util.root_pattern("nuxt.config.ts")(vim.fn.getcwd()) then
    -- OR
    if client.name == "volar" then
      for _, client_ in pairs(active_clients) do
        -- stop tsserver if volar is already active
        if client_.name == "tsserver" or client_.name == "typescript-tools" then client_.stop() end
      end
    elseif client.name == "tsserver" or client.name == "typescript-tools" then
      for _, client_ in pairs(active_clients) do
        -- prevent tsserver from starting if volar is already active
        if client_.name == "volar" then client.stop() end
      end
    end
  end,
})

local function get_typescript_server_path(root_dir)
  local lspconfig = require("lspconfig")
  local project_ts = ""
  local mason_registry = require("mason-registry")
  local tsserver_path = mason_registry.get_package("typescript-language-server"):get_install_path()
    .. "/node_modules/typescript/lib"
  local function check_dir(path)
    project_ts = lspconfig.util.path.join(path, "node_modules", "typescript", "lib")
    if lspconfig.util.path.exists(project_ts) then return path end
  end
  if lspconfig.util.search_ancestors(root_dir, check_dir) then
    return project_ts
  else
    return tsserver_path
  end
end

M.on_new_config = function(new_config, new_root_dir)
  new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
end

M.filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" }

M.root_dir = require("lspconfig.util").root_pattern("src/App.vue")

return M
