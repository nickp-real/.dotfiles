local align = { provider = "%=" }
local space = { provider = " " }

-- components
local decoration = require("plugins.heirline.components.decoration")
local diagnostic = require("plugins.heirline.components.diagnostic")
local file = require("plugins.heirline.components.file")
local git = require("plugins.heirline.components.git")
local project = require("plugins.heirline.components.project")
local ruler = require("plugins.heirline.components.ruler")
local vimode = require("plugins.heirline.components.vimode")

local fileicon = require("plugins.heirline.components.fileicon")

return {
  decoration.bar,
  vimode,
  space,
  project,
  space,
  diagnostic,
  align,
  fileicon,
  file.name,
  file.flags,
  align,
  git,
  space,
  ruler.ruler,
}
