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

-- Format Option
local format_options = vim.api.nvim_create_augroup("Format Options", { clear = true })
vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    vim.schedule(function()
      vim.opt.formatoptions = vim.opt.formatoptions
        - "a" -- Auto formatting is BAD.
        - "t" -- Don't auto format my code. I got linters for that.
        + "c" -- In general, I like it when comments respect textwidth
        + "q" -- Allow formatting comments w/ gq
        - "o" -- O and o, don't continue comments
        + "r" -- But do continue when pressing enter.
        + "n" -- Indent past the formatlistpat, not underneath it.
        + "j" -- Auto-remove comments if possible.
        - "2" -- I'm not in gradeschool anymore
    end)
  end,
  group = format_options,
})

-- Alpha bufferline
local alpha = vim.api.nvim_create_augroup("Alpha", { clear = true })
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = { "AlphaReady" },
  callback = function()
    vim.opt_local.showtabline = 0
    vim.opt_local.laststatus = 0
    vim.opt_local.ruler = false
    vim.api.nvim_create_autocmd("BufUnload", {
      buffer = 0,
      callback = function()
        vim.opt_local.showtabline = 2
        vim.opt_local.laststatus = 3
        vim.opt_local.ruler = true
      end,
      group = alpha,
    })
  end,
  group = alpha,
})

-- Hide autocmd in TelescopePrompt
local cmp_telescope = vim.api.nvim_create_augroup("Disable Cmp in TelescopePrompt", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopePrompt",
  callback = function()
    local status_ok, cmp = pcall(require, "cmp")
    if not status_ok then
      return
    end
    cmp.setup.buffer({ enabled = false })
  end,
  group = cmp_telescope,
})
