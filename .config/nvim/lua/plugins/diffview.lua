local M = {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
}

function M.config()
  local diffview = require("diffview")
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
end

return M
