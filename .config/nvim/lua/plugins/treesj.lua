local status_ok, treesj = pcall(require, "treesj")
if not status_ok then
  return
end

treesj.setup({
  use_default_keymap = false,
})
