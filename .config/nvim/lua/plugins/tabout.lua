local M = {
  "abecodes/tabout.nvim",
  keys = { { "<Tab>", mode = "i" }, { "<S-Tab>", mode = "i" } },
}

M.config = {
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
}

return M
