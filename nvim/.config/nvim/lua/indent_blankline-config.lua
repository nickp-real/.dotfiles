vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_current_context = true

require("indent_blankline").setup({
	indentLine_enabled = 1,
	char = "▏",
	buftype_exclude = { "terminal", "help", "nofile", "prompt", "popup" },
	filetype_exclude = {
		"alpha",
		"packer",
		"TelescopePrompt",
		"TelescopeResults",
		"terminal",
		"help",
		"lsp-installer",
		"log",
		"Outline",
		"Trouble",
	},
	show_trailing_blankline_indent = false,
	-- show_first_indent_level = false,
})
