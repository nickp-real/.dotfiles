-- Config
vim.opt.autowriteall = true
vim.opt.backupdir = "~/.cache/vim"
-- vim.opt.cc = "80"
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }
vim.opt.equalalways = false
vim.opt.ffs = "unix"
vim.opt.fileencoding = "utf-8"
vim.opt.magic = true
vim.opt.mouse = "a"
vim.opt.scrolloff = 8
vim.opt.shell = "fish"
vim.opt.showbreak = string.rep(" ", 3)
vim.opt.showmatch = true
vim.opt.sidescrolloff = 8
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.title = true
vim.opt.wildoptions = "pum"
vim.opt.updatetime = 250
vim.opt.undofile = true

-- UI
vim.opt.cursorline = true
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.guicursor:append({ "n-i:blinkon1" })
vim.opt.laststatus = 3
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.pumheight = 10
vim.opt.relativenumber = true
vim.opt.ruler = false
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

-- Tap
vim.opt.autoindent = true
vim.opt.breakindent = true
vim.opt.cindent = true
vim.opt.smartindent = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- Search
-- vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.inccommand = "split"

-- text thing
vim.opt.linebreak = true
vim.opt.textwidth = 79
vim.opt.wrap = true
vim.opt.spell = true

-- Clipboard
vim.g.clipboard = {
  name = "xsel",
  copy = {
    ["+"] = "xsel -i -b",
    ["*"] = "xsel -i -p",
  },
  paste = {
    ["+"] = "xsel -o -b",
    ["*"] = "xsel -o -p",
  },
  cache_enabled = 0,
}
vim.opt.clipboard = "unnamedplus"

vim.g.python3_host_prog = "/usr/bin/python"

-- nvim filetype load
vim.g.did_load_filetypes = 0
vim.g.do_filetype_lua = 1

-- Cursor Line on each window
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
  vim.api.nvim_create_autocmd(event, {
    group = group,
    pattern = pattern,
    callback = function()
      vim.opt_local.cursorline = value
    end,
  })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

-- Border and hide STL
vim.opt.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  stl = " ",
  stlnc = " ",
  eob = " ",
}
