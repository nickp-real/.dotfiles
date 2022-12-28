-- Core
require("core.option")
require("core.lazy")
require("core.autocmd")
require("utils.auto_shebang")

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    require("core.mapping")
    require("core.user_cmd")
    require("utils.coderunner")
  end,
})
