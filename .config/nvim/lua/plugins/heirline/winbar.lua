local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local file = require("plugins.heirline.components.file")
local navic = require("plugins.heirline.components.navic")
local utils_components = require("plugins.heirline.components.utils")
local utils_function = require("plugins.heirline.utils")

local concat_chevron = {
  provider = utils_components.chevron_right.provider,
  condition = function() return require("nvim-navic").is_available() and require("nvim-navic").get_location() ~= "" end,
}

local file_status = utils.clone({
  file.flags,
  utils_components.space,
  utils.clone({
    file.icon,
    utils.clone(file.name, { hl = { fg = "white" } }),
    utils_components.space,
  }, {}),
}, {
  hl = function()
    if conditions.is_active() then return { bg = "cursorline" } end
    return { bg = nil }
  end,
})

local dir = utils.clone({
  file.dirname,
}, {
  condition = function() return utils_function.get_dir_name() ~= "." end,
})

local file_name = {
  init = function(self) self.filename = file.get_file_name() end,
  flexible = 1,
  {
    provider = function(self) return self.filename end,
  },
  { provider = function(self) return self.filename:sub(1, 1) .. ".." end },
}

local file_data = utils.clone({
  utils.clone(utils_components.chevron_right, {
    condition = function() return utils_function.get_dir_name() ~= "." end,
  }),
  file.icon,
  file_name,
}, {
  condition = function() return file.get_file_name() ~= "" end,
})

local breadcrumbs = utils.clone({
  dir,
  file_data,
  concat_chevron,
  navic,
}, {
  condition = function()
    return not conditions.buffer_matches({ filetype = { "gitcommit", "Trouble", "alpha", "FTerm" } })
  end,
})

return {
  breadcrumbs,
  utils_components.align,
  file_status,
}
