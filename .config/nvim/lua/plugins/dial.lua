local M = {
  "monaqa/dial.nvim",
}

M.keys = {
  { "<C-a>", '<cmd>require("dial.map").inc_normal()<cr>', desc = "Normal Increment" },
  { "<C-x>", '<cmd>require("dial.map").dec_normal()<cr>', desc = "Normal Decrement" },
  { "<C-a>", '<cmd>require("dial.map").inc_visual()<cr>', desc = "Visual Increment" },
  { "<C-x>", '<cmd>require("dial.map").dec_visual()<cr>', desc = "Visual Decrement" },
  { "g<C-a>", '<cmd>require("dial.map").inc_gvisual()<cr>', desc = "Gvisual Increment" },
  { "g<C-x>", '<cmd>require("dial.map").dec_gvisual()<cr>', desc = "Gvisual Decrement" },
}

function M.config()
  local augend = require("dial.augend")
  require("dial.config").augends:register_group({
    default = {
      augend.integer.alias.decimal,
      augend.integer.alias.hex,
      augend.date.alias["%Y/%m/%d"],
      augend.constant.alias.bool,
    },
  })
end

return M
