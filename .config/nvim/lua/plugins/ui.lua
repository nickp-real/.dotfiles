local indent_highlight = {
  "RainbowWhite",
  "RainbowViolet",
  "RainbowBlue",
  "RainbowGreen",
  "RainbowYellow",
  "RainbowOrange",
  "RainbowRed",
  "RainbowCyan",
}

return {
  -- dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    init = function()
      local disable_bufferline = vim.api.nvim_create_augroup("Disable Bufferline", { clear = true })
      vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
        desc = "disable bufferline, winbar, tabline when filetype is man and alpha",
        pattern = { "man", "alpha" },
        callback = function()
          local old_laststatus = vim.opt_local.laststatus
          local old_tabline = vim.opt_local.showtabline
          local old_winbar = vim.opt_local.winbar
          vim.api.nvim_create_autocmd("BufUnload", {
            buffer = 0,
            callback = function()
              vim.opt_local.laststatus = old_laststatus
              vim.opt_local.showtabline = old_tabline
              vim.opt_local.winbar = old_winbar
            end,
            group = disable_bufferline,
          })
          vim.opt_local.laststatus = 0
          vim.opt_local.showtabline = 0
          vim.opt_local.winbar = nil
        end,
        group = disable_bufferline,
      })
    end,
    opts = function()
      local function footer()
        local version = vim.version()
        local nvim_version_info = "  󰀨 v" .. version.major .. "." .. version.minor .. "." .. version.patch
        return nvim_version_info
      end

      local function button(sc, txt, keybind)
        local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

        local opts = {
          position = "center",
          text = txt,
          shortcut = sc,
          cursor = 5,
          width = 50,
          align_shortcut = "right",
          hl = "AlphaButtons",
          hl_shortcut = "AlphaShortcut",
        }

        if keybind then opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } } end

        return {
          type = "button",
          val = txt,
          on_press = function()
            local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
            vim.api.nvim_feedkeys(key, "normal", false)
          end,
          opts = opts,
        }
      end

      local fn = vim.fn
      local marginTopPercent = 0.125
      local headerPadding = fn.max({ 2, fn.floor(fn.winheight(0) * marginTopPercent) })

      local options = {
        header = {
          type = "text",
          val = {
            [[      ___           ___           ___           ___                       ___     ]],
            [[     /\__\         /\  \         /\  \         /\__\          ___        /\__\    ]],
            [[    /::|  |       /::\  \       /::\  \       /:/  /         /\  \      /::|  |   ]],
            [[   /:|:|  |      /:/\:\  \     /:/\:\  \     /:/  /          \:\  \    /:|:|  |   ]],
            [[  /:/|:|  |__   /::\~\:\  \   /:/  \:\  \   /:/__/  ___      /::\__\  /:/|:|__|__ ]],
            [[ /:/ |:| /\__\ /:/\:\ \:\__\ /:/__/ \:\__\  |:|  | /\__\  __/:/\/__/ /:/ |::::\__\]],
            [[ \/__|:|/:/  / \:\~\:\ \/__/ \:\  \ /:/  /  |:|  |/:/  / /\/:/  /    \/__/~~/:/  /]],
            [[     |:/:/  /   \:\ \:\__\    \:\  /:/  /   |:|__/:/  /  \::/__/           /:/  / ]],
            [[     |::/  /     \:\ \/__/     \:\/:/  /     \::::/__/    \:\__\          /:/  /  ]],
            [[     /:/  /       \:\__\        \::/  /       ~~~~         \/__/         /:/  /   ]],
            [[     \/__/         \/__/         \/__/                                   \/__/    ]],
          },
          opts = {
            position = "center",
            hl = "AlphaHeader",
          },
        },

        buttons = {
          type = "group",
          val = {
            button("e", "  New File", "<cmd>ene<bar>startinsert<CR>"),
            button("SPC f f", "󰍉  Find File", "<cmd>Telescope find_files<CR>"),
            button("SPC f n", "  File Browser"),
            button("SPC f o", "󰈢  Recently Opened Files"),
            -- button("SPC f r", "  Frecency/MRU"),
            button("SPC f g", "󰈬  Find Word", "<cmd>Telescope live_grep<cr>"),
            button("SPC f m", "  Jump to Bookmarks"),
            button("SPC s l", "󰁯  Open Last Session"),
            button("v", "  Neovim Config", "<cmd>e ~/.config/nvim/init.lua<CR>"),
            -- button("p", "  Plugin Config", "<cmd>e ~/.config/nvim/after/plugin/<CR>"),
            -- button("t", "󰃣  Theme Config", "<cmd>e ~/.config/nvim/plugin/theme.lua<CR>"),
            button("q", "  Quit NVIM", "<cmd>qa<CR>"),
          },
          opts = {
            spacing = 1,
          },
        },
        headerPaddingTop = { type = "padding", val = headerPadding },
        headerPaddingBottom = { type = "padding", val = 1 },
        footer = {
          type = "text",
          val = footer(),
          opts = {
            position = "center",
            hl = "AlphaFooter",
          },
        },
      }
      return {
        layout = {
          options.headerPaddingTop,
          options.header,
          options.headerPaddingBottom,
          options.buttons,
          options.headerPaddingBottom,
          options.footer,
        },
        opts = {},
      }
    end,
  },

  -- better ui
  {
    "stevearc/dressing.nvim",
    init = function()
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
    opts = function()
      return {
        input = {
          default_prompt = "➤ ",
          insert_only = false,
          border = vim.g.border,
          override = function(conf)
            local width = conf.width
            local title_width = string.len(conf.title)
            conf.width = math.max(width, title_width)
            conf.col = -1
            conf.row = 0
            return conf
          end,
        },
        select = {
          telescope = require("telescope.themes").get_dropdown({
            layout_strategy = "horizontal",
            layout_config = {
              horizontal = { prompt_position = "top" },
              vertical = { mirror = false },
            },
            previewer = false,
          }),
        },
      }
    end,
  },

  -- indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = {
      "HiPhish/rainbow-delimiters.nvim",
      config = function(_, opts) require("rainbow-delimiters.setup").setup(opts) end,
      opts = { highlight = indent_highlight },
    },
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    main = "ibl",
    config = function(_, opts)
      require("ibl").setup(opts)
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
    opts = {
      scope = { highlight = indent_highlight },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
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
