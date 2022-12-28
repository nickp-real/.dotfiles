local M = {
  "olimorris/onedarkpro.nvim",
  lazy = false,
  priority = 1000,
}

function M.config()
  local onedarkpro = require("onedarkpro")

  local color = require("onedarkpro.lib.color")
  local colors = onedarkpro.get_colors("onedark")

  onedarkpro.setup({
    colors = {
      onedark = {
        telescope_prompt = color.lighten(colors.bg, 0.97),
        dark_gray = color.darken(colors.bg, 0.85),
      },
    }, -- Override default colors by specifying colors for 'onelight' or 'onedark' themes
    highlights = {
      diffAdded = { fg = "#109868" },
      TelescopeBorder = {
        fg = "${dark_gray}",
        bg = "${dark_gray}",
      },
      TelescopePromptBorder = {
        fg = "${telescope_prompt}",
        bg = "${telescope_prompt}",
      },
      TelescopePromptCounter = { fg = "${fg}" },
      TelescopePromptNormal = { fg = "${fg}", bg = "${telescope_prompt}" },
      TelescopePromptPrefix = {
        fg = "${purple}",
        bg = "${telescope_prompt}",
      },
      TelescopePromptTitle = {
        fg = "${telescope_prompt}",
        bg = "${purple}",
      },
      TelescopePreviewTitle = {
        fg = "${dark_gray}",
        bg = "${green}",
      },
      TelescopeResultsTitle = {
        fg = "${dark_gray}",
        bg = "${dark_gray}",
      },

      TelescopeMatching = { fg = "${blue}" },
      TelescopeNormal = { bg = "${dark_gray}" },
      TelescopeSelection = { bg = "${telescope_prompt}" },

      -- diffChanged = { fg = "e0af68" },
      -- diffRemoved = { fg = "#9a353d" },
      AlphaHeader = { fg = "${yellow}" },
      AlphaButtons = { fg = "${white}" },
      AlphaShortcut = { fg = "${blue}" },
      AlphaFooter = { fg = "${orange}" },

      NormalFloat = { bg = "${dark_gray}" },
      FloatBorder = { bg = "${dark_gray}", fg = "${gray}" },

      NavicText = { fg = "${fg}" },

      -- rainbowcol1 = { fg = "#abb2bf" }, -- bright white
      -- rainbowcol2 = { fg = "#c678dd" }, -- purple
      -- rainbowcol3 = { fg = "#61afef" }, -- blue
      -- rainbowcol4 = { fg = "#98c379" }, -- green
      -- rainbowcol5 = { fg = "#e5c07b" }, -- bright yellow
      -- rainbowcol6 = { fg = "#d19a66" }, -- bright orange
      -- rainbowcol7 = { fg = "#e86671" }, -- bright red
    },
    plugins = {
      nvim_ts_rainbow = false,
    },
    styles = { -- Choose from "bold,italic,underline"
      strings = "NONE", -- Style that is applied to strings.
      comments = "italic", -- Style that is applied to comments
      keywords = "italic", -- Style that is applied to keywords
      functions = "italic", -- Style that is applied to functions
      variables = "NONE", -- Style that is applied to variables
      virtual_text = "NONE", -- Style that is applied to virtual text
      types = "NONE", -- Style that is applied to types
      numbers = "NONE", -- Style that is applied to numbers
      constants = "NONE", -- Style that is applied to constants
      operators = "NONE", -- Style that is applied to operators
      conditionals = "NONE", -- Style that is applied to conditionals
    },
    options = {
      bold = true, -- Use the colorscheme's opinionated bold styles?
      italic = true, -- Use the colorscheme's opinionated italic styles?
      underline = true, -- Use the colorscheme's opinionated underline styles?
      undercurl = true, -- Use the colorscheme's opinionated undercurl styles?
      cursorline = true, -- Use cursorline highlighting?
      transparency = true, -- Use a transparent background?
      terminal_colors = false, -- Use the colorscheme's colors for Neovim's :terminal?
      window_unfocused_color = false, -- When the window is out of focus, change the normal background?
    },
  })

  vim.cmd.colorscheme("onedark")
end

return M
