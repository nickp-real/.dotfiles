local M = {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
}

M.opts = {
  char = "▎",
  context_char = "▎",
  show_current_context = true,
  -- show_current_context_start = true,
  use_treesitter = true,
  buftype_exclude = { "terminal", "help", "nofile", "prompt", "popup" },
  filetype_exclude = {
    "alpha",
    "packer",
    "TelescopePrompt",
    "TelescopeResults",
    "terminal",
    "help",
    "lsp-installer",
    "log",
    "Outline",
    "Trouble",
    "lazy",
    "neo-tree",
  },
  show_trailing_blankline_indent = false,
  show_first_indent_level = false,
}

return M
