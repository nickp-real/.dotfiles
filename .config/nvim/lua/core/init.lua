if vim.loader then vim.loader.enable() end

require("core.options")
require("core.lazy")
require("core.autocmds")
require("core.filetype")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("core.mappings")
    require("core.usercmds")
  end,
})
