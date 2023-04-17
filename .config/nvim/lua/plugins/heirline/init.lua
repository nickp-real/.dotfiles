local align = { provider = "%=", hl = { bg = "bg_statusline" } }
local space = { provider = " ", hl = { bg = "bg_statusline" } }

local viMode = require("plugins.heirline.vimode")

return {
  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    opts = function()
      local file = require("plugins.heirline.file")
      local ruler = require("plugins.heirline.ruler")
      local deco = require("plugins.heirline.deco")

      local statusline = {
        deco.bar,
        viMode,
        space,
        require("plugins.heirline.project"),
        align,
        file.name,
        align,
        ruler.ruler,
        space,
        ruler.scrollBar,
      }
      local colors = require("onedarkpro.helpers").get_colors()

      return {
        statusline = statusline,
        opts = {
          colors = colors,
        },
      }
    end,
  },
}
