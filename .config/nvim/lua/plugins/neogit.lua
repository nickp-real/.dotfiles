local M = {
  "TimUntersberger/neogit",
  cmd = "Neogit",
}

function M.init()
  vim.keymap.set("n", "<leader>gs", vim.cmd.Neogit, { desc = "Neogit" })
end

M.config = {
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
