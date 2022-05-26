local telescope = require("telescope")

telescope.setup({
	defaults = {
		prompt_prefix = "  ",
		preview = {
			treesitter = true,
		},
		color_devicons = true,
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = "top",
		},
	},
})
