local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

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
