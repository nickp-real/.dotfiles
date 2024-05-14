local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local M = {}

M.name = {
  init = function(self) self.filename = vim.api.nvim_buf_get_name(0) end,
  provider = function(self)
    local filename = vim.fn.fnamemodify(self.filename, ":t")
    if filename == "" then return "[No Name]" end
    if not conditions.width_percent_below(#filename, 0.25) then filename = vim.fn.pathshorten(filename) end
    return filename
  end,
  hl = { fg = utils.get_highlight("Directory").fg },
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
