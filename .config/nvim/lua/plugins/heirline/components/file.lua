local conditions = require("heirline.conditions")
local utils_component = require("plugins.heirline.components.utils")
local utils_function = require("plugins.heirline.utils")

local M = {}

M.name = {
  init = function(self)
    local filename = vim.api.nvim_buf_get_name(0)
    self.filename = vim.fn.fnamemodify(filename, ":t")
  end,
  provider = function(self)
    local filename = self.filename
    if filename == "" then return "[No Name]" end
    if not conditions.width_percent_below(#filename, 0.25) then filename = vim.fn.pathshorten(filename) end
    return filename
  end,
  hl = { fg = "white" },
}

M.dirname = {
  init = function(self)
    self.dirname = utils_function.get_dir_name()
    if self.dirname == "." then
      self.dirname = ""
      return
    end

    local entries = {}
    local path_separator = package.config:sub(1, 1)
    local dirs = vim.split(self.dirname, path_separator, { trimempty = true })
    for i, dir in ipairs(dirs) do
      table.insert(entries, dir)
      if i ~= #dirs then table.insert(entries, utils_component.chevron_right.provider) end
    end

    self.dirname = table.concat(entries)
  end,
  provider = function(self) return self.dirname end,
  hl = { fg = "white" },
}

M.icon = {
  init = function(self)
    local filename = vim.api.nvim_buf_get_name(0)
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  provider = function(self) return self.icon and (self.icon .. " ") end,
  hl = function(self) return { fg = self.icon_color } end,
}

M.flags = {
  {
    condition = function() return vim.bo.modified end,
    provider = " [+]",
    hl = { fg = "green" },
  },
  {
    condition = function() return not vim.bo.modifiable or vim.bo.readonly end,
    provider = function()
      if vim.bo.bt == "terminal" then
        return "  "
      else
        return " "
      end
    end,
    hl = { fg = "orange" },
  },
}

return M
