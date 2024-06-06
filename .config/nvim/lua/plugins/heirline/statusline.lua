local utils = require("plugins.heirline.components.utils")
local align = utils.align
local space = utils.space

-- components
local decoration = require("plugins.heirline.components.decoration")
local diagnostic = require("plugins.heirline.components.diagnostic")
local git = require("plugins.heirline.components.git")
local project = require("plugins.heirline.components.project")
local ruler = require("plugins.heirline.components.ruler")
local vimode = require("plugins.heirline.components.vimode")

return {
  decoration.bar,
  vimode,
  space,
  project,
  space,
  diagnostic,
  align,
  git,
  space,
  ruler.ruler,
}
