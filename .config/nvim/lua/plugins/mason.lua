local M = {
  "williamboman/mason.nvim",
}

function M.config()
  local mason = require("mason")

  mason.setup({
    ui = {
      -- border = "rounded",
      icons = {
        package_installed = "",
        package_pending = "",
        package_uninstalled = "",
      },
    },
  })
  require("mason-lspconfig").setup({
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
    automatic_installation = true,
  })
end

return M
