local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local name = {
  init = function(self)
    local cwd = vim.uv.cwd()
    local projectName = cwd and vim.fn.fnamemodify(cwd, ":t") or ""
    self.projectName = projectName
    if projectName == "" then
      self.projectName = "[No Project]"
      return
    end
    if not conditions.width_percent_below(#projectName, 0.25) then
      self.projectName = vim.fn.pathshorten(projectName)
    end
  end,
  provider = function(self) return self.projectName end,
  -- change later
  hl = { fg = utils.get_highlight("Directory").fg },
}

return name
