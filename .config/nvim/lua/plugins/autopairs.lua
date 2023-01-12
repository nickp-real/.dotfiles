local M = {
  "windwp/nvim-autopairs",
  event = "InsertCharPre",
}

M.opts = {
  disable_filetype = { "TelescopePrompt", "vim" },
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },
  fast_wrap = {},
  -- enable_check_bracket_line = false,
}

return M
