local status_ok, dial_config = pcall(require, "dial.config")
if not status_ok then
  return
end

local augend = require("dial.augend")
dial_config.augends:register_group({
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,
    augend.date.alias["%Y/%m/%d"],
    augend.constant.alias.bool,
  },
})
