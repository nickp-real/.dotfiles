local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

telescope.setup({
  defaults = {
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
