return {
  -- dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    init = function()
      -- TODO: waiting for hide winbar api
      local disable_bufferline = vim.api.nvim_create_augroup("Disable Bufferline", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "man", "alpha" },
        callback = function()
          local old_laststatus = vim.opt.laststatus
          local old_tabline = vim.opt.showtabline
          vim.api.nvim_create_autocmd("BufUnload", {
            buffer = 0,
            callback = function()
              vim.opt.laststatus = old_laststatus
              vim.opt.showtabline = old_tabline
            end,
            group = disable_bufferline,
          })
          vim.opt.laststatus = 0
          vim.opt.showtabline = 0
        end,
        group = disable_bufferline,
      })
    end,
    opts = function()
      local function footer()
        local version = vim.version()
        local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
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

        if keybind then
          opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
        end

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
            button("SPC f f", "  Find File", "<cmd>Telescope find_files<CR>"),
            button("SPC f n", "  File Browser"),
            button("SPC f o", "  Recently Opened Files"),
            -- button("SPC f r", "  Frecency/MRU"),
            button("SPC f g", "  Find Word", "<cmd>Telescope live_grep<cr>"),
            button("SPC f m", "  Jump to Bookmarks"),
            button("SPC s l", "  Open Last Session"),
            button("v", "  Neovim Config", "<cmd>e ~/.config/nvim/init.lua<CR>"),
            -- button("p", "  Plugin Config", "<cmd>e ~/.config/nvim/after/plugin/<CR>"),
            -- button("t", "  Theme Config", "<cmd>e ~/.config/nvim/plugin/theme.lua<CR>"),
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
    end,
    opts = function()
      return {
        input = {
          default_prompt = "➤ ",
          insert_only = false,
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

        if last_buffer_name == "" then
          vim.cmd("Bdelete " .. last_buffer_id)
        end
      end

      return {
        { "<Tab>", "<cmd>lua ChangeTab('next')<cr>", desc = "Next Buffer" },
        { "<S-Tab>", "<cmd>lua ChangeTab('prev')<cr>", desc = "Prev Buffer" },
        { "<leader><Tab>", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer Next" },
        { "<leader><S-Tab>", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer Prev" },
      }
    end,
    opts = {
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
    },
  },

  -- winbar
  {
    "utilyre/barbecue.nvim",
    dependencies = { "SmiteshP/nvim-navic" },
    event = "VeryLazy",
    opts = {
      attach_navic = false,
      exclude_filetypes = { "gitcommit", "Trouble", "alpha", "FTerm" },
    },
  },

  -- statusline
  {
    "feline-nvim/feline.nvim",
    event = "VeryLazy",
    opts = function()
      local onedark = {
        fg = "#abb2bf",
        bg = "#282c34",
        green = "#98c379",
        yellow = "#e5c07b",
        purple = "#c678dd",
        orange = "#d19a66",
        peanut = "#f6d5a4",
        red = "#e06c75",
        aqua = "#61afef",
        darkblue = "#22252C",
        dark_red = "#f75f5f",
        cyan = "#56b6c2",
        none = "NONE",
      }

      local vi_mode_colors = {
        NORMAL = "green",
        OP = "green",
        INSERT = "yellow",
        VISUAL = "purple",
        LINES = "orange",
        BLOCK = "dark_red",
        REPLACE = "red",
        COMMAND = "aqua",
      }

      local c = {
        vim_mode = {
          provider = {
            name = "vi_mode",
            opts = {
              show_mode_name = true,
              -- padding = "center", -- Uncomment for extra padding.
            },
          },
          hl = function()
            return {
              fg = require("feline.providers.vi_mode").get_mode_color(),
              bg = "darkblue",
              style = "bold",
              name = "NeovimModeHLColor",
            }
          end,
          left_sep = "block",
          right_sep = "block",
        },
        gitBranch = {
          provider = "git_branch",
          hl = {
            fg = "peanut",
            bg = "darkblue",
            style = "bold",
          },
          left_sep = "block",
          right_sep = "block",
        },
        gitDiffAdded = {
          provider = "git_diff_added",
          hl = {
            fg = "green",
            bg = "darkblue",
          },
          left_sep = "block",
          right_sep = "block",
        },
        gitDiffRemoved = {
          provider = "git_diff_removed",
          hl = {
            fg = "red",
            bg = "darkblue",
          },
          left_sep = "block",
          right_sep = "block",
        },
        gitDiffChanged = {
          provider = "git_diff_changed",
          hl = {
            fg = "fg",
            bg = "darkblue",
          },
          left_sep = "block",
          right_sep = "right_filled",
        },
        separator = {
          provider = "",
        },
        fileinfo = {
          provider = {
            name = "file_info",
            opts = {
              type = "base-only",
            },
          },
          hl = {
            style = "bold",
          },
          left_sep = " ",
          right_sep = " ",
        },
        diagnostic_errors = {
          provider = "diagnostic_errors",
          hl = {
            fg = "red",
          },
        },
        diagnostic_warnings = {
          provider = "diagnostic_warnings",
          hl = {
            fg = "yellow",
          },
        },
        diagnostic_hints = {
          provider = "diagnostic_hints",
          hl = {
            fg = "cyan",
          },
          icon = {
            str = "  ",
          },
        },
        diagnostic_info = {
          provider = "diagnostic_info",
          hl = {
            fg = "aqua",
          },
        },
        -- lsp_client_names = {
        --   provider = "lsp_client_names",
        --   hl = {
        --     fg = "purple",
        --     bg = "darkblue",
        --     style = "bold",
        --   },
        --   left_sep = "left_filled",
        --   right_sep = "block",
        -- },
        file_type = {
          provider = {
            name = "file_type",
            opts = {
              filetype_icon = true,
              case = "titlecase",
            },
          },
          hl = {
            fg = "red",
            bg = "darkblue",
            style = "bold",
          },
          left_sep = "left_filled",
          right_sep = "block",
        },
        file_encoding = {
          provider = "file_encoding",
          hl = {
            fg = "orange",
            bg = "darkblue",
            style = "italic",
          },
          left_sep = "block",
          right_sep = "block",
        },
        position = {
          provider = "position",
          hl = {
            fg = "green",
            bg = "darkblue",
            style = "bold",
          },
          left_sep = "block",
          right_sep = "block",
        },
        line_percentage = {
          provider = "line_percentage",
          hl = {
            fg = "aqua",
            bg = "darkblue",
            style = "bold",
          },
          left_sep = "block",
          right_sep = "block",
        },
        scroll_bar = {
          provider = "scroll_bar",
          hl = {
            fg = "yellow",
            style = "bold",
          },
        },
      }

      local left = {
        c.vim_mode,
        c.gitBranch,
        c.gitDiffAdded,
        c.gitDiffRemoved,
        c.gitDiffChanged,
        c.separator,
      }

      local middle = {
        -- c.fileinfo,
        c.diagnostic_errors,
        c.diagnostic_warnings,
        c.diagnostic_info,
        c.diagnostic_hints,
      }

      local right = {
        -- c.lsp_client_names,
        c.file_type,
        c.file_encoding,
        c.position,
        c.line_percentage,
        c.scroll_bar,
      }

      local components = {
        active = {
          left,
          middle,
          right,
        },
        inactive = {
          left,
          middle,
          right,
        },
      }

      local disable_ft = {
        "^NvimTree$",
        "^packer$",
        "^startify$",
        "^fugitive$",
        "^fugitiveblame$",
        "^qf$",
        "^help$",
        "^alpha$",
        "^man$",
      }
      return {
        components = components,
        theme = onedark,
        vi_mode_colors = vi_mode_colors,
        disable = {
          filetypes = disable_ft,
        },
      }
    end,
  },

  -- indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    opts = {
      char = "▎",
      context_char = "▎",
      show_current_context = true,
      -- show_current_context_start = true,
      use_treesitter = true,
      buftype_exclude = { "terminal", "help", "nofile", "prompt", "popup" },
      filetype_exclude = {
        "alpha",
        "packer",
        "TelescopePrompt",
        "TelescopeResults",
        "terminal",
        "help",
        "lsp-installer",
        "log",
        "Outline",
        "Trouble",
        "lazy",
        "neo-tree",
      },
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
    },
  },

  -- notify
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    keys = {
      {
        "<leader>nd",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all Notifications",
      },
    },

    config = function()
      local notify = require("notify")

      local stages_util = require("notify.stages.util")

      notify.setup({
        fps = 60,
        stages = {
          function(state)
            local next_height = state.message.height + 2
            local next_row =
              stages_util.available_slot(state.open_windows, next_height, stages_util.DIRECTION.BOTTOM_UP)
            if not next_row then
              return nil
            end
            return {
              relative = "editor",
              anchor = "NE",
              width = state.message.width,
              height = state.message.height,
              col = vim.opt.columns:get(),
              row = next_row,
              border = "rounded",
              style = "minimal",
              opacity = 0,
            }
          end,
          function()
            return {
              opacity = { 100 },
              col = { vim.opt.columns:get() },
            }
          end,
          function()
            return {
              col = { vim.opt.columns:get() },
              time = true,
            }
          end,
          function()
            return {
              width = {
                1,
                frequency = 2.5,
                damping = 0.9,
                complete = function(cur_width)
                  return cur_width < 3
                end,
              },
              opacity = {
                0,
                frequency = 2,
                complete = function(cur_opacity)
                  return cur_opacity <= 4
                end,
              },
              col = { vim.opt.columns:get() },
            }
          end,
        },
      })

      vim.notify = notify
    end,
  },

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

  -- TODO comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "BufReadPost",
    config = true,
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo Trouble" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo Trouble" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
    },
  },

  -- highlight argument
  {
    "m-demare/hlargs.nvim",
    event = "BufReadPost",
    opts = { color = "#e59b4e" },
  },

  -- Log Highlight
  { "MTDL9/vim-log-highlighting", ft = "log" },

  -- nui
  "MunifTanjim/nui.nvim",

  -- Icon
  "nvim-tree/nvim-web-devicons",
}
