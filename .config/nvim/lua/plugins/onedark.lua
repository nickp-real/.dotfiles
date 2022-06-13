local status_ok, onedark = pcall(require, "onedark")
if not status_ok then
  return
end

onedark.setup({
  dark_float = false,
  dark_sidebar = true,
  sidebars = { "Outline" },
})
