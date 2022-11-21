-- Highlight on yank
local yank = vim.api.nvim_create_augroup("yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
  group = yank,
})

-- Format Option
local format_options = vim.api.nvim_create_augroup("Format Options", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.opt_local.formatoptions = vim.opt_local.formatoptions
      - "a" -- Auto formatting is BAD.
      - "t" -- Don't auto format my code. I got linters for that.
      + "c" -- In general, I like it when comments respect textwidth
      + "q" -- Allow formatting comments w/ gq
      - "o" -- O and o, don't continue comments
      + "r" -- But do continue when pressing enter.
      + "n" -- Indent past the formatlistpat, not underneath it.
      + "j" -- Auto-remove comments if possible.
      - "2" -- I'm not in gradeschool anymore
  end,
  group = format_options,
})

-- Spell
-- disable spell for filetype
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*toggleterm#*",
  callback = function()
    vim.opt_local.spell = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "html", "markdown", "text" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- Alpha Disable Bufferline
local disable_bufferline = vim.api.nvim_create_augroup("Disable Bufferline", { clear = true })
vim.api.nvim_create_autocmd("User", {
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
vim.api.nvim_create_autocmd("FileType", {
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
vim.api.nvim_create_autocmd("FileType", {
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

-- Add shebang add the top of the .sh, .py file
local appendLine = function()
  vim.fn.append(1, "")
  vim.fn.append(2, "")
  vim.fn.cursor(3, 0)
end

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = { "*.sh", "*.bash" },
  callback = function()
    vim.api.nvim_buf_set_lines(0, 0, -1, false, { "#!/usr/bin/env bash" })
    appendLine()
  end,
})

vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = { ".py" },
  callback = function()
    vim.api.nvim_buf_set_lines(0, 0, -1, false, { "#!/usr/bin/env python3" })
    appendLine()
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
