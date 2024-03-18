local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Format Option
local format_options = augroup("Format Options", { clear = true })
autocmd("FileType", {
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

-- Persistent Cursor
autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
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
autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text" },
  callback = function() vim.opt_local.spell = true end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then return end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

local disable_bufferline = vim.api.nvim_create_augroup("Disable Bufferline", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "man", "alpha" },
  callback = function()
    local old_laststatus = vim.opt_local.laststatus
    local old_tabline = vim.opt_local.showtabline
    local old_winbar = vim.opt_local.winbar
    vim.api.nvim_create_autocmd("BufUnload", {
      buffer = 0,
      callback = function()
        vim.opt_local.laststatus = old_laststatus
        vim.opt_local.showtabline = old_tabline
        vim.opt_local.winbar = old_winbar
      end,
      group = disable_bufferline,
    })
    vim.opt_local.laststatus = 0
    vim.opt_local.showtabline = 0
    vim.opt_local.winbar = nil
  end,
  group = disable_bufferline,
})
