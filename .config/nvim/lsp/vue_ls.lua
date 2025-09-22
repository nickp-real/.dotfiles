local M = {}

M.filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" }

M.init_options = { vue = { hybridMode = true } }

M.root_dir = require("lspconfig.util").root_pattern("src/App.vue")

return M
