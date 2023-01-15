local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
-- Highlight on yank
local yank = augroup("yank", { clear = true })
autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
  group = yank,
})

-- Format Option
local format_options = augroup("Format Options", { clear = true })
autocmd("BufReadPost", {
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
autocmd("TermOpen", {
  pattern = "term://*toggleterm#*",
  callback = function()
    vim.opt_local.spell = false
  end,
})

-- Alpha Disable Bufferline
local disable_bufferline = augroup("Disable Bufferline", { clear = true })
autocmd("FileType", {
  pattern = { "man", "alpha" },
  callback = function()
    local old_laststatus = vim.opt.laststatus
    local old_tabline = vim.opt.showtabline
    autocmd("BufUnload", {
      buffer = 0,
      callback = function()
        vim.opt.laststatus = old_laststatus
        vim.opt.showtabline = old_tabline
      end,
      group = disable_bufferline,
    })
    vim.opt.laststatus = 0
    vim.opt.showtabline = 0
  end,
  group = disable_bufferline,
})

-- Use 'q' to quit from common plugins
autocmd("FileType", {
  pattern = {
    "help",
    "man",
    "lspinfo",
    "trouble",
    "null-ls-info",
    "qf",
    "help",
    "notify",
    "startuptime",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Persistent Folds
local save_fold = augroup("Persistent Folds", { clear = true })
autocmd("BufWinLeave", {
  pattern = "*.*",
  callback = function()
    vim.cmd.mkview()
  end,
  group = save_fold,
})
autocmd("BufWinEnter", {
  pattern = "*.*",
  callback = function()
    vim.cmd.loadview({ mods = { emsg_silent = true } })
  end,
  group = save_fold,
})

-- Persistent Cursor
autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Cursor Line on each window
local cursorline = augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
  autocmd(event, {
    group = cursorline,
    pattern = pattern,
    callback = function()
      vim.opt_local.cursorline = value
    end,
  })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, { "TelescopePrompt", "alpha" })

-- Textfile spell
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.spell = true
  end,
})
