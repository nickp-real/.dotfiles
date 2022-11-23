local status_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not status_ok then
  return
end

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
