local opt = vim.opt
local g = vim.g

-- Config
opt.completeopt = "menu,menuone,noselect"
opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }
opt.mouse = "a"
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.shell = "fish"
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
opt.swapfile = false
opt.title = true
opt.wildoptions = "pum"
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- UI
opt.laststatus = 3
opt.number = true
opt.numberwidth = 4
opt.pumheight = 10
opt.relativenumber = true
opt.ruler = false
opt.showmode = false
opt.signcolumn = "yes"
opt.termguicolors = true
opt.winminwidth = 10

-- Indenting
opt.breakindent = true
opt.smartindent = true
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"

-- Text Thing
opt.linebreak = true
opt.whichwrap = opt.whichwrap:append("<,>,[,],h,l")
opt.virtualedit = "block"
opt.wrap = false

-- Performance
opt.timeoutlen = 300
opt.updatetime = 250

-- grep
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

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

-- Clipboard
-- opt.clipboard = "unnamedplus"

-- fix markdown indent
g.markdown_recommended_style = 0

-- Session
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,globals"

-- env
g.python3_host_prog = "/usr/bin/python3"
