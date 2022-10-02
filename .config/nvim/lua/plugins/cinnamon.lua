local status_ok, cinnamon = pcall(require, "cinnamon")
if not status_ok then
  return
end

cinnamon.setup({
  extra_keymap = true,
  exteded_keymap = true,
  -- override_keymap = true,
})
