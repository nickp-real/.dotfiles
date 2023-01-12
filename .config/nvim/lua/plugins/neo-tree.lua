local M = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  cmd = "Neotree",
}

M.keys = {
  { "<C-n>", "<cmd>Neotree reveal toggle<cr>", desc = "Neo-tree" },
}

function M.init()
  vim.g.neo_tree_remove_legacy_commands = 1
  if vim.fn.argc() == 1 then
    local stat = vim.loop.fs_stat(vim.fn.argv(0))
    if stat and stat.type == "directory" then
      require("neo-tree")
    end
  end
end

function M.opts()
  return {
    filesystem = {
      hijack_netrw_behavior = "open_current",
      follow_current_file = true,
      use_libuv_file_watcher = true,
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function(file_path)
          --auto close
          require("neo-tree").close_all()
        end,
      },
    },
  }
end

return M
