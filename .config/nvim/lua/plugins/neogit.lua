local status_ok, neogit = pcall(require, "neogit")
if not status_ok then
  return
end

neogit.setup({
  kind = "split",
  disable_builtin_notifications = true,
  disable_commit_confirmation = true,
  signs = {
    -- { CLOSED, OPENED }
    section = { "", "" },
    item = { "", "" },
  },
  integrations = {
    diffview = true,
  },
})
