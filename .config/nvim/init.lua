-- Fast Startup
pcall("require", "impatient")

-- Core
require("core.plugins")
require("core.theme")
require("core.config")
require("core.autocmd")
require("core.disable_builtin")
require("core.mapping")
require("core.snippet-config")

-- Plugins
require("plugins.alpha-config")
require("plugins.autopairs-config")
require("plugins.bufferline-config")
require("plugins.colorizer-config")
require("plugins.comment-config")
require("plugins.completion")
require("plugins.dap-config")
require("plugins.dressing-config")
require("plugins.gitsigns-config")
require("plugins.indent_blankline-config")
require("plugins.neoscroll-config")
require("plugins.nvim_tree-config")
require("plugins.session-manager-config")
require("plugins.symbol-outline-config")
require("plugins.telescope-config")
require("plugins.toggleterm_config")
require("plugins.treesitter")

-- LSP
require("plugins.lsp.lspconfigs")
require("plugins.lsp.null_ls")
