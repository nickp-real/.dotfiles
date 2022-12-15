local opt = vim.opt
local opt_local = vim.opt_local
local g = vim.g

-- Config
opt.autowriteall = true
opt.completeopt = { "menu", "menuone", "noselect" }
opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }
opt.mouse = "a"
opt.scrolloff = 8
opt.shell = "fish"
opt.showbreak = string.rep(" ", 3)
opt.shortmess:append("c")
opt.splitbelow = true
opt.splitright = true
opt.swapfile = false
opt.title = true
opt.wildoptions = "pum"
opt.winfixwidth = true
opt.undofile = true

-- UI
-- opt.cmdheight = 0
opt.cursorline = true
-- opt.foldcolumn = "1"
-- opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = true
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldnestmax = 0
-- opt.foldmethod = "expr"
opt.guicursor:append({ "n-i:blinkon1" })
opt.laststatus = 3
opt.number = true
opt.numberwidth = 4
opt.pumheight = 10
opt.relativenumber = true
opt.ruler = false
opt.showmode = false
opt.signcolumn = "yes"
opt.termguicolors = true

-- Indenting
opt.breakindent = true
opt.smartindent = true
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2

-- Search
-- opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"

-- text thing
opt.linebreak = true
opt.textwidth = 80
opt.whichwrap:append("<,>,[,],h,l")

-- Performance
opt.redrawtime = 1500
opt.timeoutlen = 500
opt.ttimeoutlen = 25
opt.updatetime = 500

-- Session
g.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

-- Leader key
g.mapleader = " "

-- Clipboard
g.clipboard = {
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
opt.clipboard = "unnamedplus"

-- Cursor Line on each window
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
  vim.api.nvim_create_autocmd(event, {
    group = group,
    pattern = pattern,
    callback = function()
      opt_local.cursorline = value
    end,
  })
end
local no_cursor = { "TelescopePrompt", "alpha" }
set_cursorline("WinLeave", false, no_cursor)
set_cursorline("WinEnter", true, no_cursor)
set_cursorline("FileType", false, no_cursor)

-- Border and hide STL
opt.fillchars = {
  horiz = "━",
  horizup = "┻",
  horizdown = "┳",
  vert = "┃",
  vertleft = "┫",
  vertright = "┣",
  stl = " ",
  stlnc = " ",
  eob = " ",
  diff = "╱",
  -- fold = " ",
  -- foldopen = "",
  -- foldsep = " ",
  -- foldclose = "",
}

-- env
g.python3_host_prog = "/usr/bin/python3"

-- Neotree
g.neo_tree_remove_legacy_commands = 1
