local M = {
  "aserowy/tmux.nvim",
  event = "VeryLazy",
}

function M.config()
  local tmux = require("tmux")

  tmux.setup({
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
  })

  local keymap_utils = require("utils.keymap_utils")
  local nnoremap = keymap_utils.nnoremap

  -- navigation
  nnoremap("<A-h>", tmux.move_left)
  nnoremap("<A-j>", tmux.move_bottom)
  nnoremap("<A-k>", tmux.move_top)
  nnoremap("<A-l>", tmux.move_right)

  -- resize
  nnoremap("<A-Up>", tmux.resize_top)
  nnoremap("<A-Down>", tmux.resize_bottom)
  nnoremap("<A-Left>", tmux.resize_left)
  nnoremap("<A-Right>", tmux.resize_right)
end

return M
