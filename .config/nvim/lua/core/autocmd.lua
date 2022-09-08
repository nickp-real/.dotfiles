-- Highlight on yank
local yank = vim.api.nvim_create_augroup("yank", { clear = true })
vim.api.nvim_create_autocmd(
  "TextYankPost",
  { pattern = "*", command = 'lua vim.highlight.on_yank({higroup="Visual", timeout=200})', group = yank }
)

-- -- Format Option
local format_options = vim.api.nvim_create_augroup("Format Options", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
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

-- disable spell for filetype
vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = "term://*toggleterm#*",
  callback = function()
    vim.opt_local.spell = false
  end,
})

-- Alpha Disable Bufferline
local disable_bufferline = vim.api.nvim_create_augroup("Disable Bufferline", { clear = true })
vim.api.nvim_create_autocmd({ "User" }, {
  pattern = { "AlphaReady" },
  callback = function()
    vim.opt_local.showtabline = 0
    vim.opt_local.laststatus = 0
    vim.api.nvim_create_autocmd("BufUnload", {
      buffer = 0,
      callback = function()
        vim.opt_local.showtabline = 2
        vim.opt_local.laststatus = 3
      end,
      group = disable_bufferline,
    })
  end,
  group = disable_bufferline,
})
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "man",
  callback = function()
    vim.opt_local.showtabline = 0
    vim.api.nvim_create_autocmd("BufUnload", {
      buffer = 0,
      callback = function()
        vim.opt_local.showtabline = 2
      end,
      group = disable_bufferline,
    })
  end,
  group = disable_bufferline,
})

-- Use 'q' to quit from common plugins
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "qf",
    "help",
    "man",
    "lspinfo",
    "spectre_panel",
    "lir",
    "startuptime",
    "trouble",
    "null-ls-info",
  },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "q", ":close<cr>", { silent = true })
    vim.bo.buflisted = false
  end,
})

-- vim.api.nvim_create_autocmd({ "VimLeave" }, {
--   callback = function()
--     vim.api.nvim_exec("!~/.local/share/nvim/mason/bin/eslint_d stop", {})
--   end,
-- })

-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = "qf",
--   callback = function()
--     vim.api.nvim_buf_set_keymap(0, "n", "<cr>", "<cr>:cclose<cr>", { silent = true })
--     vim.bo.buflisted = false
--   end,
-- })
