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
        float_bg = "require('onedarkpro.helpers').darken('bg', 4, 'onedark')", -- dark gray
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

      AlphaHeader = { fg = "${yellow}" },
      AlphaButtons = { fg = "${white}" },
      AlphaShortcut = { fg = "${blue}" },
      AlphaFooter = { fg = "${orange}" },

      NormalFloat = { bg = "${float_bg}" },
      FloatBorder = { bg = "${float_bg}", fg = "${gray}" },

      NavicText = { fg = "${fg}" },

      RainbowWhite = { fg = "${white}" },
      RainbowViolet = { fg = "${purple}" },
      RainbowBlue = { fg = "${blue}" },
      RainbowGreen = { fg = "${green}" },
      RainbowYellow = { fg = "${yellow}" },
      RainbowOrange = { fg = "${orange}" },
      RainbowRed = { fg = "${red}" },
      RainbowCyan = { fg = "${cyan}" },

      MasonNormal = { bg = "${telescope_results}" },
      LazyNormal = { bg = "${telescope_results}" },
      TreesitterContext = { bg = "${telescope_results}" },

      NotifyERRORBody = { link = "NormalFloat" },
      NotifyWARNBody = { link = "NormalFloat" },
      NotifyINFOBody = { link = "NormalFloat" },
      NotifyDEBUGBody = { link = "NormalFloat" },
      NotifyTRACEBody = { link = "NormalFloat" },
      NotifyERRORBorder = { bg = "${float_bg}", extend = true },
      NotifyWARNBorder = { bg = "${float_bg}", extend = true },
      NotifyINFOBorder = { bg = "${float_bg}", extend = true },
      NotifyDEBUGBorder = { bg = "${float_bg}", extend = true },
      NotifyTRACEBorder = { bg = "${float_bg}", extend = true },
    },
    -- plugins = {},
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
      parameters = "NONE",
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
