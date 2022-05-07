require("bufferline").setup({
	options = {
		diagnostics = "nvim_lsp",
		diagnostics_update_in_insert = false,
		indicator_icon = "▌",
		offsets = {
			{
				filetype = "Outline",
				text = "Symbols Outline",
				highlight = "Directory",
				text_align = "center",
			},
			{
				filetype = "NvimTree",
				text = "Nvim Tree",
				highlight = "Directory",
				text_align = "center",
			},
		},
	},
})
