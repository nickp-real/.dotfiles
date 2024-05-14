local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local name = {
  provider = function()
    local projectName = vim.fn.fnamemodify(vim.loop.cwd(), ":t")
    if projectName == "" then return "[No Project]" end
    if not conditions.width_percent_below(#projectName, 0.25) then projectName = vim.fn.pathshorten(projectName) end
    return projectName
  end,
  -- change later
  hl = { fg = utils.get_highlight("Directory").fg },
}

return name
