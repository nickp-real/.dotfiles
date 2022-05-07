require("gitsigns").setup({
	signs = {
		add = { text = "▌" },
		change = { text = "▌" },
		delete = { text = "▌" },
		topdelete = { text = "▌" },
		changedelete = { text = "▌" },
	},
	numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
	preview_config = { border = "rounded" },
	current_line_blame = true,
})
