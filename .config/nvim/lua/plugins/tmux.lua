local M = {
  "aserowy/tmux.nvim",
  event = "VeryLazy",
}

M.keys = {
  -- navigation
  { "<A-h>", "<cmd>lua require('tmux').move_left()<cr>" },
  { "<A-j>", "<cmd>lua require('tmux').move_bottom()<cr>" },
  { "<A-k>", "<cmd>lua require('tmux').move_top()<cr>" },
  { "<A-l>", "<cmd>lua require('tmux').move_right()<cr>" },

  -- resize
  { "<A-Up>", "<cmd>lua require('tmux').resize_top()<cr>" },
  { "<A-Down>", "<cmd>lua require('tmux').resize_bottom()<cr>" },
  { "<A-Left>", "<cmd>lua require('tmux').resize_left()<cr>" },
  { "<A-Right>", "<cmd>lua require('tmux').resize_right()<cr>" },
}

M.opts = {
  copy_sync = {
    sync_clipboard = false,
  },
  navigation = {
    -- enables default keybindings (C-hjkl) for normal mode
    enable_default_keybindings = false,
  },
  resize = {
    -- enables default keybindings (A-hjkl) for normal mode
    enable_default_keybindings = false,

    -- sets resize steps for x axis
    resize_step_x = 10,

    -- sets resize steps for y axis
    resize_step_y = 10,
  },
}

return M
