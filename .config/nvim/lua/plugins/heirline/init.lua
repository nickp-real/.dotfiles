local viMode = require("vimode").display

return {
  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    opts = function()
      local statusline = { viMode }
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
