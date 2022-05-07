-- Config
vim.opt.backupdir = "~/.cache/vim"
vim.opt.cc = "80"
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = "menu,menuone,noselect,noinsert,preview"
vim.opt.cursorline = true
vim.opt.diffopt = { "internal", "filler", "closeoff", "hiddenoff", "algorithm:minimal" }
vim.opt.equalalways = false
vim.opt.ffs = "unix"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.guicursor:append({ "n-i:blinkon1" })
vim.opt.joinspaces = false
vim.opt.laststatus = 3
vim.opt.magic = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.numberwidth = 4
vim.opt.pumheight = 10
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shell = "fish"
vim.opt.showbreak = string.rep(" ", 3)
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.wildoptions = "pum"
vim.opt.updatetime = 250

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
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.inccommand = "split"

-- Wrap thing
vim.opt.linebreak = true
vim.opt.textwidth = 80
vim.opt.wrap = true

-- Format Option
vim.opt.formatoptions = vim.opt.formatoptions
	- "a" -- Auto formatting is BAD.
	- "t" -- Don't auto format my code. I got linters for that.
	+ "c" -- In general, I like it when comments respect textwidth
	+ "q" -- Allow formatting comments w/ gq
	- "o" -- O and o, don't continue comments
	+ "r" -- But do continue when pressing enter.
	+ "n" -- Indent past the formatlistpat, not underneath it.
	+ "j" -- Auto-remove comments if possible.
	- "2" -- I'm not in gradeschool anymore

vim.g.python3_host_prog = "/usr/bin/python3"

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
