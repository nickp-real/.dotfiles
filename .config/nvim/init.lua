-- Fast Startup
require("plugins.impatient")

-- Core
require("core.disable_builtin")
require("core.option")
require("core.plugins")
require("core.colorscheme")
require("core.autocmd")
vim.schedule(function()
  require("core.mapping")
  require("core.coderunner")
end)
