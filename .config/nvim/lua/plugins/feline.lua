local M = {
  "feline-nvim/feline.nvim",
  event = "VeryLazy",
}

function M.config()
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
    c.fileinfo,
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

  local wc = {
    navic = {
      provider = function()
        return require("nvim-navic").get_location()
      end,
      enabled = function()
        return require("nvim-navic").is_available()
      end,
      hl = {
        bg = "none",
      },
    },
    filepath = {
      provider = {
        name = "file_info",
        opts = {
          type = "relative-short",
          file_modified_icon = "",
          file_readonly_icon = "",
        },
      },
      hl = {
        bg = "none",
      },
    },
    separator = {
      provider = ": ",
      hl = {
        bg = "none",
      },
    },
  }

  local winbar_components = {
    active = {
      { wc.filepath, wc.separator, wc.navic },
    },
    inactive = {
      { wc.filepath, wc.separator, wc.navic },
    },
  }
  local feline = require("feline")

  feline.setup({
    components = components,
    theme = onedark,
    vi_mode_colors = vi_mode_colors,
    disable = {
      filetypes = {
        "^NvimTree$",
        "^packer$",
        "^startify$",
        "^fugitive$",
        "^fugitiveblame$",
        "^qf$",
        "^help$",
        "^alpha$",
        "^man$",
      },
    },
  })

  feline.winbar.setup({
    components = winbar_components,
    disable = {
      filetypes = {
        "^NvimTree$",
        "^packer$",
        "^startify$",
        "^fugitive$",
        "^fugitiveblame$",
        "^qf$",
        "^help$",
        "^alpha$",
        "^man$",
      },
    },
  })
end

return M
