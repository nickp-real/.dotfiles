local utils = require("heirline.utils")

local file = require("plugins.heirline.components.file")
local navic = require("plugins.heirline.components.navic")
local utils_components = require("plugins.heirline.components.utils")

local concat_chevron = {
  condition = function() return require("nvim-navic").is_available() and require("nvim-navic").get_location() ~= "" end,
  provider = utils_components.chevron_right.provider,
}

local file_status = {
  file.flags,
  utils_components.space,
  file.icon,
  utils.clone(file.name, { hl = { fg = utils.get_highlight("Directory").fg } }),
}

return {
  file.dirname,
  utils_components.chevron_right,
  file.icon,
  file.name,
  concat_chevron,
  navic,
  utils_components.align,
  file_status,
}
