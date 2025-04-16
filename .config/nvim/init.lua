vim.loader.enable()

require("config.styles")
require("config.options")
require("config.filetypes")
require("config.lazy")
require("config.lsp")

local group = vim.api.nvim_create_augroup("startup_lazy_load", { clear = true })
vim.api.nvim_create_autocmd("User", {
  desc = "lazy load on startup",
  group = group,
  pattern = "VeryLazy",
  callback = function()
    -- require("utils.cmd_ui")
    require("config.mappings")
    require("config.autocmds")
    require("config.usercmds")
  end,
})
