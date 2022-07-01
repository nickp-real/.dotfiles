local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
  return
end

luasnip.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
})

luasnip.snippets = {
  all = {},
  html = {},
}

-- enable html snippets in javascript/javascript(REACT)
luasnip.snippets.javascript = luasnip.snippets.html
luasnip.snippets.javascriptreact = luasnip.snippets.html
luasnip.snippets.typescriptreact = luasnip.snippets.html

luasnip.filetype_extend("dart", { "flutter" })
require("luasnip.loaders.from_vscode").lazy_load()
