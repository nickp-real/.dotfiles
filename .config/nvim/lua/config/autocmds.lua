local create_autocmd = vim.api.nvim_create_autocmd
local create_augroup = vim.api.nvim_create_augroup

create_autocmd("TextYankPost", {
  desc = "highlight on yank",
  group = create_augroup("highlight_yank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

local format_options = create_augroup("format_options", { clear = true })
create_autocmd("FileType", {
  desc = "set format options, expr",
  callback = function() vim.opt_local.formatoptions = "jcrqln" end,
  group = format_options,
})

create_autocmd("FileType", {
  desc = "use 'q' to quit from common plugins",
  pattern = {
    "help",
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

create_autocmd("BufWritePre", {
  desc = "auto create dir when saving a file, in case some intermediate directory does not exist",
  group = create_augroup("auto_create_dir", { clear = true }),
  callback = function(event)
    if event.match:match("^%w%w+://") then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

create_autocmd("VimResized", {
  desc = "auto resize splited windows",
  pattern = "*",
  command = "tabdo wincmd =",
})

-- create_autocmd({ "BufWinEnter" }, {
--   callback = function(event)
--     local buf = event.buf
--     if not vim.api.nvim_get_option_value("buflisted", { buf = buf }) then return end
--
--     local new_buf = vim.api.nvim_create_buf(false, true)
--     vim.api.nvim_set_option_value("number", false, { scope = "local", win = new_buf })
--     vim.api.nvim_set_option_value("relativenumber", false, { scope = "local", win = new_buf })
--     vim.bo[new_buf].buftype = "nofile"
--     vim.bo[new_buf].bufhidden = "wipe"
--     vim.bo[new_buf].buflisted = false
--     vim.bo[new_buf].swapfile = false
--     -- vim.bo[new_buf].modifiable = false
--     vim.api.nvim_buf_set_lines(new_buf, 0, -1, true, { "test" })
--
--     vim.api.nvim_open_win(
--       new_buf,
--       false,
--       { relative = "win", row = -1, col = vim.api.nvim_win_get_width(0), width = 10, height = 1 }
--     )
--   end,
-- })

-- create_autocmd("BufWritePost", {
--   desc = "Notify when file saved",
--   callback = function(event)
--     vim.notify(
--       vim.fn.fnamemodify(event.file, ":~:.:h") .. "/" .. vim.fn.fnamemodify(event.file, ":t") .. " has been saved.",
--       vim.log.levels.INFO,
--       { title = "File saved" }
--     )
--   end,
-- })

-- create_autocmd("BufWinLeave", {
--   callback = function(event)
--     local buffers = vim.fn.getbufinfo({ bufloaded = 1, buflisted = 1 })
--     vim.iter(buffers):each(function(a) print(a.lastused) end)
--     -- vim.print(buffers)
--   end,
-- })
