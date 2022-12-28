local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-media-files.nvim",
  },
  cmd = "Telescope",
}

function M.config()
  local telescope = require("telescope")

  telescope.setup({
    defaults = {
      pickers = {
        find_files = {
          find_command = { "fd", "--hidden", "--glob", "" },
        },
      },
      prompt_prefix = "  ",
      path_display = { "smart" },
      preview = {
        treesitter = true,
      },
      color_devicons = true,
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.6,
          results_width = 0.4,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      file_ignore_patterns = { ".git/", "node_modules" },
      mappings = {
        i = {
          ["<C-u>"] = false,
        },
      },
    },
  })

  telescope.load_extension("fzf")
  telescope.load_extension("file_browser")
  telescope.load_extension("media_files")
end

return M
