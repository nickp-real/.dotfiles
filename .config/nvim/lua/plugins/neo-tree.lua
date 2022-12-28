local M = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  cmd = "Neotree",
}

function M.config()
  vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
  local neotree = require("neo-tree")

  neotree.setup({
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
          neotree.close_all()
        end,
      },
    },
  })
end

return M
