local status_ok, tabout = pcall(require, "tabout")
if not status_ok then
  return
end

tabout.setup({
  act_as_shift_tab = true,
  tabouts = {
    { open = "'", close = "'" },
    { open = '"', close = '"' },
    { open = "`", close = "`" },
    { open = "(", close = ")" },
    { open = "[", close = "]" },
    { open = "{", close = "}" },
    { open = '["', close = '"]' },
  },
})
