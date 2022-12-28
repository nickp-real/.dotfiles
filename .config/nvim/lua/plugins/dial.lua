local M = {
  "monaqa/dial.nvim",
  keys = { "<C-a>", "<C-x>" },
}

function M.config()
  local dial_config = require("dial.config")
  local augend = require("dial.augend")
  dial_config.augends:register_group({
    default = {
      augend.integer.alias.decimal,
      augend.integer.alias.hex,
      augend.date.alias["%Y/%m/%d"],
      augend.constant.alias.bool,
    },
  })

  local keymap_utils = require("utils.keymap_utils")
  local nnoremap = keymap_utils.nnoremap
  local vnoremap = keymap_utils.vnoremap

  -- Keymap
  nnoremap("<C-a>", require("dial.map").inc_normal())
  nnoremap("<C-x>", require("dial.map").dec_normal())
  vnoremap("<C-a>", require("dial.map").inc_visual())
  vnoremap("<C-x>", require("dial.map").dec_visual())
  vnoremap("g<C-a>", require("dial.map").inc_gvisual())
  vnoremap("g<C-x>", require("dial.map").dec_gvisual())
end

return M
