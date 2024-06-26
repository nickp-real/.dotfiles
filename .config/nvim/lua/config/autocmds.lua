local create_autocmd = vim.api.nvim_create_autocmd
local create_augroup = vim.api.nvim_create_augroup

create_autocmd("TextYankPost", {
  desc = "highlight on yank",
  group = create_augroup("highlight_yank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

local format_options = create_augroup("Format Options", { clear = true })
create_autocmd("FileType", {
  desc = "set format options, expr",
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

create_autocmd("FileType", {
  desc = "use 'q' to quit from common plugins",
  pattern = {
    "help",
    "man",
    "lspinfo",
    "qf",
    "notify",
    "startuptime",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

create_autocmd("BufReadPost", {
  desc = "persistent cursor, last file position",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
  end,
})

create_autocmd({ "InsertLeave", "WinEnter" }, {
  desc = "show cursor line on current window",
  callback = function()
    local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
    if ok and cl then
      vim.wo.cursorline = true
      vim.api.nvim_win_del_var(0, "auto-cursorline")
    end
  end,
})

create_autocmd({ "InsertEnter", "WinLeave" }, {
  desc = "hide cursor line on other window",
  callback = function()
    local cl = vim.wo.cursorline
    if cl then
      vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
      vim.wo.cursorline = false
    end
  end,
})

create_autocmd("FileType", {
  desc = "enable spell on text file",
  pattern = { "gitcommit", "markdown", "text" },
  callback = function() vim.opt_local.spell = true end,
})

create_autocmd({ "BufWritePre" }, {
  desc = "auto create dir when saving a file, in case some intermediate directory does not exist",
  group = create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then return end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

create_autocmd("VimResized", {
  desc = "auto resize splited windows",
  pattern = "*",
  command = "tabdo wincmd =",
})
