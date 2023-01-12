local M = {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
}

M.keys = {
  { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview" },
  { "<leader>gF", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview File History (cwd)" },
  { "<leader>gf", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview File History (root dir)" },
}

function M.config(_, opts)
  require("diffview").setup(opts)

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

M.opts = {
  view = {
    merge_tool = {
      layout = "diff3_mixed",
    },
  },
}

return M
