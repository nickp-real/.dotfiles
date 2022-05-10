require("onedark").setup({
	dark_float = true,
	dark_sidebar = true,
	sidebars = { "Outline", "terminal", "toggleterm", "packer", "qf", "Trouble" },
})
local lualine = require("lualine")
local signs = { error = " ", warn = " ", hint = " ", info = " " }
local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn", "info", "hint" },
	symbols = signs,
	colored = true,
	update_in_insert = false,
	always_visible = true,
}

lualine.setup({
	options = {
		icons_enabled = true,
		-- theme = "onedark-nvim",
		-- component_separators = { left = "", right = "" },
		-- component_separators = "|",
		-- section_separators = { left = "", right = "" },
		component_separators = "",
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha" },
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = {
			{ "mode", separator = { left = "" }, right_padding = 2 },
		},
		lualine_b = {
			"branch",
			"diff",
			diagnostics,
		},
		lualine_c = {
			"%=",
			{
				"filename",
				flie_status = true,
			},
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = {
			{ "location", separator = { right = "" }, left_padding = 2 },
		},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			"%=",
			{
				"filename",
				flie_status = true,
			},
		},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {
		"nvim-tree",
		"toggleterm",
		"fugitive",
		"symbols-outline",
	},
})

-- LSP progress indicator
require("fidget").setup({})

-- Hide Status Line, Lualine
vim.cmd([[
  hi StatusLine gui=NONE guifg=NONE guibg=NonText guisp=NonText
  hi StatusLineNc gui=NONE guifg=NONE guibg=NonText guisp=NonText
  hi WinSeparator guibg=None guifg=#393f4a
]])

local colorscheme = vim.api.nvim_create_augroup("colorscheme", { clear = true })
vim.api.nvim_create_autocmd(
	"ColorScheme",
	{ pattern = "*", command = "highlight NormalFloat guibg=#1f2335", group = colorscheme }
)
vim.api.nvim_create_autocmd(
	"ColorScheme",
	{ pattern = "*", command = "highlight FloatBorder guibg=#1f2335", group = colorscheme }
)

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
