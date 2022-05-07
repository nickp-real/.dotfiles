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

telescope.load_extension("fzf")
telescope.load_extension("file_browser")
telescope.load_extension("flutter")
