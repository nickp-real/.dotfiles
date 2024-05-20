if vim.loader then vim.loader.enable() end

require("config.options")
require("config.filetypes")
require("config.autocmds")
require("config.styles")
require("config.lazy")

local group = vim.api.nvim_create_augroup("Startup lazy load", { clear = true })
vim.api.nvim_create_autocmd("User", {
  desc = "lazy load on startup",
  group = group,
  pattern = "VeryLazy",
  callback = function()
    require("config.mappings")
    require("config.usercmds")
  end,
})
