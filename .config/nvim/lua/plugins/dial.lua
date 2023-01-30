local M = {
  "monaqa/dial.nvim",
}

function M.keys()
  return {
    {
      "<C-a>",
      function()
        return require("dial.map").inc_normal()
      end,
      desc = "Increment",
      expr = true,
      mode = { "n", "v" },
    },
    {
      "<C-x>",
      function()
        return require("dial.map").dec_normal()
      end,
      desc = "Decrement",
      expr = true,
      mode = { "n", "v" },
    },
    {
      "g<C-a>",
      function()
        return require("dial.map").inc_gvisual()
      end,
      desc = "Gvisual Increment",
      expr = true,
      mode = "v",
    },
    {
      "g<C-x>",
      function()
        return require("dial.map").dec_gvisual()
      end,
      desc = "Gvisual Decrement",
      expr = true,
      mode = "v",
    },
  }
end

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
