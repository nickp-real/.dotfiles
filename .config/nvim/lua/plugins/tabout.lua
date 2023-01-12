local M = {
  "abecodes/tabout.nvim",
}

M.keys = { { "<Tab>", mode = "i" }, { "<S-Tab>", mode = "i" } }

M.opts = {
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
