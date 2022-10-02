local status_ok, luasnip = pcall(require, "luasnip")
if not status_ok then
  return
end

luasnip.config.set_config({
  history = true,
  updateevents = "TextChanged,TextChangedI",
  region_check_events = "CursorHold,InsertLeave,InsertEnter",
  delete_check_events = "TextChanged,InsertEnter",
  enable_autosnippets = true,
})

luasnip.snippets = {
  all = {},
  html = {},
}

-- enable html snippets in javascript/typescript (REACT)
luasnip.filetype_extend("javascriptreact", { "html" })
luasnip.filetype_extend("typescriptreact", { "html" })

luasnip.filetype_extend("dart", { "flutter" })
require("luasnip.loaders.from_vscode").lazy_load()
