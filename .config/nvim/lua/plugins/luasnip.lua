local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
  return
end

luasnip.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
})
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.filetype_extend("dart", { "flutter" })
