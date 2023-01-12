local M = {
  "TimUntersberger/neogit",
}

M.keys = {
  { "<leader>gs", vim.cmd.Neogit, desc = "Neogit" },
}

M.opts = {
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
}

return M
