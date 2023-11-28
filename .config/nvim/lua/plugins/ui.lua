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
    init = false,
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
      local marginTopPercent = 0.15
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
        headerPaddingBottom = { type = "padding", val = 2 },
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
          border = require("core.styles").border,
          win_options = {
            winblend = 0,
          },
          override = function(conf)
            conf.col = -1
            conf.row = 0
            return conf
          end,
        },
        select = {
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
        },
      }
    end,
  },

  -- bufferline
  {
    "akinsho/bufferline.nvim",
    dependencies = {
      { "roobert/bufferline-cycle-windowless.nvim", opts = { default_enabled = true } },
    },
    event = "VeryLazy",
    keys = function()
      function ChangeTab(motion)
        local last_buffer_id = vim.fn.bufnr()
        local last_buffer_name = vim.fn.expand("%")

        if motion == "next" then
          vim.cmd.BufferLineCycleWindowlessNext()
        elseif motion == "prev" then
          vim.cmd.BufferLineCycleWindowlessPrev()
        else
          error("Invalid motion: " .. motion)
          return
        end

        if last_buffer_name == "" then vim.cmd("Bdelete " .. last_buffer_id) end
      end

      return {
        { "<Tab>", function() ChangeTab("next") end, desc = "Next Buffer" },
        { "<S-Tab>", function() ChangeTab("prev") end, desc = "Prev Buffer" },
        { "<leader><Tab>", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer Next" },
        { "<leader><S-Tab>", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer Prev" },
      }
    end,
    opts = function()
      -- local Offset = require("bufferline.offset")
      -- if not Offset.edgy then
      --   local get = Offset.get
      --   Offset.get = function()
      --     if package.loaded.edgy then
      --       local layout = require("edgy.config").layout
      --       local ret = { left = "", left_size = 0, right = "", right_size = 0 }
      --       for _, pos in ipairs({ "left", "right" }) do
      --         local sb = layout[pos]
      --         if sb and #sb.wins > 0 then
      --           local title = " Sidebar" .. string.rep(" ", sb.bounds.width - 8)
      --           ret[pos] = "%#EdgyTitle#" .. title .. "%*" .. "%#WinSeparator#│%*"
      --           ret[pos .. "_size"] = sb.bounds.width
      --         end
      --       end
      --       ret.total_size = ret.left_size + ret.right_size
      --       if ret.total_size > 0 then return ret end
      --     end
      --     return get()
      --   end
      --   Offset.edgy = true
      return {
        options = {
          diagnostics = "nvim_lsp",
          diagnostics_update_in_insert = false,
          close_command = "Bdelete! %d",
          always_show_bufferline = false,
          indicator = {
            icon = "▌",
            style = "icon",
          },
          offsets = {
            {
              filetype = "Outline",
              text = "Symbols Outline",
              highlight = "Directory",
              text_align = "center",
            },
            {
              filetype = "neo-tree",
              text = "Neo Tree",
              highlight = "Directory",
              text_align = "center",
            },
          },
        },
        highlights = {
          indicator_selected = {
            fg = "#61afef",
          },
        },
      }
      -- end
    end,
  },

  -- winbar
  {
    "utilyre/barbecue.nvim",
    dependencies = { "SmiteshP/nvim-navic", init = function() vim.g.navic_silence = true end },
    event = "VeryLazy",
    opts = {
      attach_navic = false,
      exclude_filetypes = { "gitcommit", "Trouble", "alpha", "FTerm" },
    },
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
      vim.notify = function(message, level, notify_opts) return notify(message, level, notify_opts) end
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
              border = require("core.styles").border,
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

  -- edgy
  -- {
  --   "folke/edgy.nvim",
  --   event = "VeryLazy",
  --   keys = {
  --     { "<C-n>", '<cmd>lua require("edgy").toggle()<cr>', desc = "Edgy Toggle" },
  --     -- { "<C-N>", '<cmd>lua require("edgy").select()<cr>', desc = "Edgy Select Window" },
  --   },
  --   opts = {
  --     bottom = {
  --       "Trouble",
  --       { ft = "qf", title = "QuickFix" },
  --       {
  --         ft = "help",
  --         size = { height = 20 },
  --         -- don't open help files in edgy that we're editing
  --         filter = function(buf) return vim.bo[buf].buftype == "help" end,
  --       },
  --       { title = "Spectre", ft = "spectre_panel", size = { height = 0.4 } },
  --     },
  --     left = {
  --       -- Neo-tree filesystem always takes half the screen height
  --       {
  --         title = "Neo-Tree",
  --         ft = "neo-tree",
  --         filter = function(buf) return vim.b[buf].neo_tree_source == "filesystem" end,
  --         pinned = true,
  --         open = "Neotree",
  --         size = { height = 0.5 },
  --       },
  --       {
  --         title = "Neo-Tree Git",
  --         ft = "neo-tree",
  --         filter = function(buf) return vim.b[buf].neo_tree_source == "git_status" end,
  --         pinned = true,
  --         open = "Neotree position=right git_status",
  --       },
  --       {
  --         title = "Neo-Tree Buffers",
  --         ft = "neo-tree",
  --         filter = function(buf) return vim.b[buf].neo_tree_source == "buffers" end,
  --         pinned = true,
  --         open = "Neotree position=top buffers",
  --       },
  --       {
  --         ft = "Outline",
  --         pinned = true,
  --         open = "SymbolsOutline",
  --       },
  --       -- any other neo-tree windows
  --       "neo-tree",
  --     },
  --   },
  -- },

  -- better quickfix
  {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {
      func_map = {
        open = "",
        openc = "<CR>",
      },
    },
  },

  -- Log Highlight
  { "MTDL9/vim-log-highlighting", ft = "log" },

  -- nui
  "MunifTanjim/nui.nvim",

  -- Icon
  "nvim-tree/nvim-web-devicons",
}
