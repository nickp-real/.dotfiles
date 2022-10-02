local status_ok, diffview = pcall(require, "diffview")
if not status_ok then
  return
end

diffview.setup({
  view = {
    merge_tool = {
      layout = "diff3_mixed",
    },
  },
})

-- DiffviewOpen and Close in one command
vim.api.nvim_create_user_command("DiffviewToggle", function(e)
  local view = require("diffview.lib").get_current_view()

  if view then
    vim.cmd("DiffviewClose")
  else
    vim.cmd("DiffviewOpen " .. e.args)
  end
end, { nargs = "*" })
