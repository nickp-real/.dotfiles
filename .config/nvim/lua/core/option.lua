local opt = vim.opt
local opt_local = vim.opt_local
local g = vim.g

-- Config
opt.autowriteall = true
opt.completeopt = { "menu", "menuone", "noselect" }
opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }
opt.equalalways = false
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
opt.undofile = true

-- UI
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
opt.lazyredraw = true
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
opt.textwidth = 79
opt.spell = true
opt.whichwrap:append("<,>,[,],h,l")

-- Performance
opt.redrawtime = 1500
opt.timeoutlen = 250
opt.ttimeoutlen = 10
opt.updatetime = 100

-- Leader key
g.mapleader = " "

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
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

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
