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
    vim.opt_local.wrap = false
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
autocmd({ "InsertLeave", "WinEnter" }, {
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})
autocmd({ "InsertEnter", "WinLeave" }, {
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})

-- Textfile spell
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.spell = true
  end,
})
