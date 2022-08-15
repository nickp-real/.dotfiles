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
luasnip.filetype_extend("javascript", { "html" })
luasnip.filetype_extend("typescript", { "html" })
luasnip.filetype_extend("javascriptreact", { "html" })
luasnip.filetype_extend("typescriptreact", { "html" })

luasnip.filetype_extend("dart", { "flutter" })
require("luasnip.loaders.from_vscode").lazy_load()
