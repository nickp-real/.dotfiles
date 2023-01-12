local M = {
  "williamboman/mason.nvim",
  cmd = "Mason",
}

function M.config(_, opts)
  require("mason").setup(opts)

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

M.opts = {
  ui = {
    -- border = "rounded",
    icons = {
      package_installed = "",
      package_pending = "",
      package_uninstalled = "",
    },
  },
}

return M
