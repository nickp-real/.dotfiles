-- local status_ok, onedark = pcall(require, "onedark")
-- if not status_ok then
--   return
-- end

-- onedark.setup({
--   dark_float = true,
--   dark_sidebar = true,
--   sidebars = { "Outline" },
--   dev = true,
--   overrides = function(c)
--     return {
--       -- Telescope
--       -- CursorWord Highlight
--       LspReferenceText = { bg = "#343a45" },
--       LspReferenceWrite = { bg = "#343a45" },
--       LspReferenceRead = { bg = "#343a45" },
--       illuminatedWord = { bg = "#343a45" },
--       illuminatedCurWord = { bg = "#343a45" },

--       -- DevIcons
--       DevIconC = { fg = c.dev_icons.blue },
--       DevIconClojure = { fg = c.dev_icons.green0 },
--       DevIconCoffee = { fg = c.dev_icons.yellow },
--       DevIconCs = { fg = c.dev_icons.blue },
--       DevIconCss = { fg = c.dev_icons.blue },
--       DevIconMarkdown = { fg = c.dev_icons.blue },
--       DevIconGo = { fg = c.dev_icons.blue },
--       DevIconHtm = { fg = c.dev_icons.orange },
--       DevIconHtml = { fg = c.dev_icons.orange },
--       DevIconJava = { fg = c.dev_icons.red },
--       DevIconJs = { fg = c.dev_icons.yellow },
--       DevIconJson = { fg = c.dev_icons.yellow },
--       DevIconLess = { fg = c.dev_icons.yellow },
--       DevIconMakefile = { fg = c.dev_icons.orange },
--       DevIconMustache = { fg = c.dev_icons.orange },
--       DevIconPhp = { fg = c.dev_icons.purple },
--       DevIconPython = { fg = c.dev_icons.blue },
--       DevIconErb = { fg = c.dev_icons.red },
--       DevIconRb = { fg = c.dev_icons.red },
--       DevIconSass = { fg = c.dev_icons.pink },
--       DevIconScss = { fg = c.dev_icons.pink },
--       DevIconSh = { fg = c.dev_icons.gray },
--       DevIconSql = { fg = c.dev_icons.pink },
--       DevIconTs = { fg = c.dev_icons.blue },
--       DevIconXml = { fg = c.dev_icons.orange },
--       DevIconYaml = { fg = c.dev_icons.purple },
--       DevIconYml = { fg = c.dev_icons.purple },

--       -- Cmp
--       -- PmenuSel = { bg = c.bg0, fg = c.none },
--       -- Pmenu = { fg = c.fg_light, bg = c.bg1 },

--       -- CmpItemAbbrDeprecated = { fg = c.fg_gutter, bg = c.none, fmt = "strikethrough" },
--       -- CmpItemAbbrMatch = { fg = c.blue0, bg = c.none, fmt = "bold" },
--       -- CmpItemAbbrMatchFuzzy = { fg = c.blue0, bg = c.none, fmt = "bold" },
--       -- CmpItemMenu = { fg = c.purple0, bg = c.none, fmt = "italic" },

--       -- CmpItemKindField = { fg = "#ffffff", bg = c.red1 },
--       -- CmpItemKindProperty = { fg = "#ffffff", bg = c.red1 },
--       -- CmpItemKindEvent = { fg = "#ffffff", bg = c.red1 },

--       -- CmpItemKindText = { fg = "#ffffff", bg = c.green0 },
--       -- CmpItemKindEnum = { fg = "#ffffff", bg = c.green0 },
--       -- CmpItemKindKeyword = { fg = "#ffffff", bg = c.green0 },

--       -- CmpItemKindConstant = { fg = "#ffffff", bg = c.yellow0 },
--       -- CmpItemKindConstructor = { fg = "#ffffff", bg = c.yellow0 },
--       -- CmpItemKindReference = { fg = "#ffffff", bg = c.yellow0 },

--       -- CmpItemKindFunction = { fg = "#ffffff", bg = c.purple0 },
--       -- CmpItemKindStruct = { fg = "#ffffff", bg = c.purple0 },
--       -- CmpItemKindClass = { fg = "#ffffff", bg = c.purple0 },
--       -- CmpItemKindModule = { fg = "#ffffff", bg = c.purple0 },
--       -- CmpItemKindOperator = { fg = "#ffffff", bg = c.purple0 },

--       -- CmpItemKindVariable = { fg = "#ffffff", bg = c.fg_dark },
--       -- CmpItemKindFile = { fg = "#ffffff", bg = c.fg_dark },

--       -- CmpItemKindUnit = { fg = "#ffffff", bg = c.orange1 },
--       -- CmpItemKindSnippet = { fg = "#ffffff", bg = c.orange1 },
--       -- CmpItemKindFolder = { fg = "#ffffff", bg = c.orange1 },

--       -- CmpItemKindMethod = { fg = "#ffffff", bg = c.blue1 },
--       -- CmpItemKindValue = { fg = "#ffffff", bg = c.blue1 },
--       -- CmpItemKindEnumMember = { fg = "#ffffff", bg = c.blue1 },

--       -- CmpItemKindInterface = { fg = "#ffffff", bg = c.cyan0 },
--       -- CmpItemKindColor = { fg = "#ffffff", bg = c.cyan0 },
--       -- CmpItemKindTypeParameter = { fg = "#ffffff", bg = c.cyan0 },
--     }
--   end,
-- })

local status_ok, onedarkpro = pcall(require, "onedarkpro")
if not status_ok then
  return
end

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

vim.cmd("colorscheme onedark")
