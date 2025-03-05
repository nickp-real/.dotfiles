local conditions = require("heirline.conditions")
local utils_component = require("plugins.heirline.components.utils")
local utils_function = require("plugins.heirline.utils")

local M = {}

---@param buffer? number
---@return string
M.get_file_name = function(buffer) return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buffer or 0), ":t") end

M.name = {
  init = function(self) self.filename = M.get_file_name() end,
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
    self.dirs = vim.split(self.dirname, path_separator, { trimempty = true })
    for i, dir in ipairs(self.dirs) do
      table.insert(entries, dir)
      if i ~= #self.dirs then table.insert(entries, utils_component.chevron_right.provider) end
    end

    self.dirname = table.concat(entries)
  end,
  hl = { fg = "white" },
  flexible = 1,
  {
    provider = function(self) return self.dirname end,
  },
  {
    provider = function(self)
      local entries = {}
      for i, dir in ipairs(self.dirs) do
        table.insert(entries, dir:sub(1, 1) .. "..")
        if i ~= #self.dirs then table.insert(entries, utils_component.chevron_right.provider) end
      end
      return table.concat(entries)
    end,
  },
}

M.icon = {
  init = function(self)
    local filename = vim.api.nvim_buf_get_name(0)
    local extension = vim.fn.fnamemodify(filename, ":e")
    local icon, hl, _ = require("mini.icons").get("extension", extension)
    self.icon = icon
    self.icon_color = vim.api.nvim_get_hl(0, { name = hl }).fg
  end,
  provider = function(self) return self.icon and (self.icon .. " ") end,
  hl = function(self) return { fg = self.icon_color } end,
}

M.flags = {
  {
    condition = function() return vim.bo.modified end,
    provider = " ",
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
