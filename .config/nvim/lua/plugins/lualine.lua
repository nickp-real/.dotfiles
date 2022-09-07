local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local signs = { error = " ", warn = " ", hint = " ", info = " " }
local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn", "info", "hint" },
  symbols = signs,
  colored = true,
  update_in_insert = false,
  always_visible = true,
}

lualine.setup({
  options = {
    icons_enabled = true,
    -- theme = "onedark-nvim",
    -- component_separators = { left = "", right = "" },
    -- component_separators = "|",
    -- section_separators = { left = "", right = "" },
    component_separators = "",
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha" },
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      { "mode", separator = { left = "" }, right_padding = 2 },
    },
    lualine_b = {
      "branch",
      {
        "diff",
        symbols = { added = " ", modified = " ", removed = " " },
      },
      diagnostics,
    },
    lualine_c = {
      "%=",
      {
        "filename",
        flie_status = true,
      },
    },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = {
      { "location", separator = { right = "" }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      "%=",
      {
        "filename",
        flie_status = true,
      },
    },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {
    "nvim-tree",
    "toggleterm",
    "fugitive",
    "symbols-outline",
  },
})

-- Hide Status Line, Lualine
vim.cmd([[
  hi StatusLine gui=NONE guifg=NONE guibg=NonText guisp=NonText
  hi StatusLineNc gui=NONE guifg=NONE guibg=NonText guisp=NonText
  hi WinSeparator guibg=None guifg=#393f4a
]])
