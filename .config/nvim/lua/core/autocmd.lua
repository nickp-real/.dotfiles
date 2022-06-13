-- Colorsheme
local colorscheme = vim.api.nvim_create_augroup("colorscheme", { clear = true })
vim.api.nvim_create_autocmd(
  "ColorScheme",
  { pattern = "*", command = "highlight NormalFloat guibg=#1f2335", group = colorscheme }
)
vim.api.nvim_create_autocmd(
  "ColorScheme",
  { pattern = "*", command = "highlight FloatBorder guibg=#1f2335", group = colorscheme }
)

-- Highlight on yank
local yank = vim.api.nvim_create_augroup("yank", { clear = true })
vim.api.nvim_create_autocmd(
  "TextYankPost",
  { pattern = "*", command = 'lua vim.highlight.on_yank({higroup="Visual", timeout=200})', group = yank }
)
