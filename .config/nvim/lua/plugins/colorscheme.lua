return {
  "olimorris/onedarkpro.nvim",
  lazy = false,
  priority = 1000,
  config = function(_, opts)
    require("onedarkpro").setup(opts)
    vim.cmd.colorscheme("onedark")
  end,
  opts = {
    colors = {
      dark = {
        telescope_prompt = "require('onedarkpro.helpers').darken('bg', 1, 'onedark')",
        telescope_results = "require('onedarkpro.helpers').darken('bg', 4, 'onedark')", -- dark gray
        telescope_preview = "require('onedarkpro.helpers').darken('bg', 6, 'onedark')",
        telescope_selection = "require('onedarkpro.helpers').darken('bg', 8, 'onedark')",
      },
    }, -- Override default colors by specifying colors for 'onelight' or 'onedark' themes
    highlights = {
      TelescopeBorder = {
        fg = "${telescope_results}",
        bg = "${telescope_results}",
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
        fg = "${telescope_results}",
        bg = "${green}",
      },
      TelescopeResultsTitle = {
        fg = "${telescope_results}",
        bg = "${telescope_results}",
      },
      TelescopeMatching = { fg = "${blue}" },
      TelescopeNormal = { bg = "${telescope_results}" },
      TelescopeSelection = { bg = "${telescope_selection}" },
      TelescopePreviewNormal = { bg = "${telescope_preview}" },
      TelescopePreviewBorder = { fg = "${telescope_preview}", bg = "${telescope_preview}" },

      -- diffChanged = { fg = "e0af68" },
      -- diffRemoved = { fg = "#9a353d" },
      AlphaHeader = { fg = "${yellow}" },
      AlphaButtons = { fg = "${white}" },
      AlphaShortcut = { fg = "${blue}" },
      AlphaFooter = { fg = "${orange}" },

      NormalFloat = { bg = "${telescope_results}" },
      FloatBorder = { bg = "${telescope_results}", fg = "${gray}" },

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
    styles = {
      types = "NONE",
      methods = "bold",
      numbers = "NONE",
      strings = "NONE",
      comments = "italic",
      keywords = "bold,italic",
      constants = "NONE",
      functions = "bold",
      operators = "NONE",
      variables = "NONE",
      parameters = "italic",
      conditionals = "italic",
      virtual_text = "NONE",
    },
    options = {
      cursorline = true, -- Use cursorline highlighting?
      transparency = true, -- Use a transparent background?
      terminal_colors = false, -- Use the colorscheme's colors for Neovim's :terminal?
      window_unfocused_color = false, -- When the window is out of focus, change the normal background?
    },
  },
}
