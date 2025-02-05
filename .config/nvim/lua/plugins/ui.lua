return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = function(_, opts) require("rainbow-delimiters.setup").setup(opts) end,
    opts = { highlight = vim.g.indent_highlights },
  },

  -- notify
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    keys = {
      {
        "<leader>nd",
        function() require("notify").dismiss({ silent = true, pending = true }) end,
        desc = "Delete all Notifications",
      },
    },
    config = function(_, opts)
      local notify = require("notify")
      notify.setup(opts)
      vim.notify = notify
    end,
    opts = function()
      local stages_util = require("notify.stages.util")
      local direction = stages_util.DIRECTION.BOTTOM_UP
      return {
        fps = 60,
        top_down = false,
        stages = {
          function(state)
            local next_height = state.message.height + 2
            local next_row = stages_util.available_slot(state.open_windows, next_height, direction)
            if not next_row then return nil end
            return {
              relative = "editor",
              anchor = "NE",
              width = state.message.width,
              height = state.message.height,
              col = vim.opt.columns:get(),
              row = next_row,
              border = vim.g.border,
              style = "minimal",
              opacity = 0,
            }
          end,
          function(state, win)
            return {
              opacity = { 100 },
              col = { vim.opt.columns:get() },
              row = {
                stages_util.slot_after_previous(win, state.open_windows, direction),
                frequency = 3,
                complete = function() return true end,
              },
            }
          end,
          function(state, win)
            return {
              col = { vim.opt.columns:get() },
              time = true,
              row = {
                stages_util.slot_after_previous(win, state.open_windows, direction),
                frequency = 3,
                complete = function() return true end,
              },
            }
          end,
          function(state, win)
            return {
              width = {
                1,
                frequency = 2.5,
                damping = 0.9,
                complete = function(cur_width) return cur_width < 3 end,
              },
              opacity = {
                0,
                frequency = 2,
                complete = function(cur_opacity) return cur_opacity <= 4 end,
              },
              col = { vim.opt.columns:get() },
              row = {
                stages_util.slot_after_previous(win, state.open_windows, direction),
                frequency = 3,
                complete = function() return true end,
              },
            }
          end,
        },
      }
    end,
  },

  -- Log Highlight
  { "MTDL9/vim-log-highlighting", ft = "log" },

  -- nui
  "MunifTanjim/nui.nvim",

  -- Icon
  "nvim-tree/nvim-web-devicons",
}
