-- Fast Startup
require("plugins.impatient")

-- Core
require("core.disable_builtin")
require("core.option")
require("core.plugins")
require("core.mapping")
require("core.colorscheme")
require("core.autocmd")
require("core.user_cmd")
vim.schedule(function()
  require("core.coderunner")
end)
