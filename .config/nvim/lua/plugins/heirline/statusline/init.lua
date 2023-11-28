local align = { provider = "%=", hl = { bg = "bg_statusline" } }
local space = { provider = " ", hl = { bg = "bg_statusline" } }

-- components
local deco = require("plugins.heirline.statusline.deco")
local vimode = require("plugins.heirline.statusline.vimode")
local project = require("plugins.heirline.statusline.project")
local diagnostic = require("plugins.heirline.statusline.diagnostic")
local file = require("plugins.heirline.statusline.file")
local git = require("plugins.heirline.statusline.git")
local ruler = require("plugins.heirline.statusline.ruler")

return {
  deco.bar,
  vimode,
  space,
  project,
  space,
  diagnostic,
  align,
  file.name,
  align,
  git,
  space,
  ruler.ruler,
}
