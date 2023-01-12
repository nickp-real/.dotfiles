local M = {
  "stevearc/dressing.nvim",
}

function M.init()
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.ui.select = function(...)
    require("lazy").load({ plugins = { "dressing.nvim" } })
    return vim.ui.select(...)
  end
  ---@diagnostic disable-next-line: duplicate-set-field
  vim.ui.input = function(...)
    require("lazy").load({ plugins = { "dressing.nvim" } })
    return vim.ui.input(...)
  end
end

function M.opts()
  return {
    input = {
      -- Set to false to disable the vim.ui.input implementation
      enabled = true,

      -- Default prompt string
      default_prompt = "➤ ",

      -- When true, <Esc> will close the modal
      insert_only = false,

      -- These are passed to nvim_open_win
      anchor = "SW",
      relative = "cursor",
      border = "rounded",

      -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      prefer_width = 40,
      max_width = nil,
      min_width = 20,

      win_options = {
        -- Window transparency (0-100)
        winblend = 0,
        -- Change default highlight groups (see :help winhl)
        winhighlight = "",
      },

      -- see :help dressing_get_config
      get_config = nil,
      override = function(conf)
        conf.col = -1
        conf.row = 0
        return conf
      end,
    },
    select = {
      -- Set to false to disable the vim.ui.select implementation
      enabled = true,

      -- Priority list of preferred vim.select implementations
      backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

      telescope = require("telescope.themes").get_dropdown({
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
          },
          vertical = {
            mirror = false,
          },
        },
        previewer = false,
      }),

      -- Options for fzf selector
      fzf = {
        window = {
          width = 0.5,
          height = 0.4,
        },
      },

      -- Options for fzf_lua selector
      fzf_lua = {
        winopts = {
          width = 0.5,
          height = 0.4,
        },
      },

      -- Options for nui Menu
      nui = {
        position = "50%",
        size = nil,
        relative = "editor",
        border = {
          style = "rounded",
        },
        max_width = 80,
        max_height = 40,
      },

      -- Options for built-in selector
      builtin = {
        -- These are passed to nvim_open_win
        anchor = "NW",
        relative = "cursor",
        border = "rounded",

        win_options = {
          -- Window transparency (0-100)
          winblend = 0,
          -- Change default highlight groups (see :help winhl)
          winhighlight = "",
        },

        -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        width = nil,
        max_width = 0.8,
        min_width = 40,
        height = nil,
        max_height = 0.9,
        min_height = 10,
      },

      -- Used to override format_item. See :help dressing-format
      -- 		format_item_override = {

      --         },

      format_item_override = {},
      -- see :help dressing_get_config
      get_config = nil,
    },
  }
end

return M
