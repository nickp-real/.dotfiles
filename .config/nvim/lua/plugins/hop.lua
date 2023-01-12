local M = {
  "phaazon/hop.nvim",
  branch = "v2", -- optional but strongly recommended
  cmd = { "HopChar1", "HopWord" },
}

M.keys = {
  { "s", ":HopChar1<cr>", desc = "Hop 1 Char" },
  { "S", ":HopWord<cr>", desc = "Hop word" },
}

M.opts = { keys = "etovxqpdygfblzhckisuran" }

return M
