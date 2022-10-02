local status_ok, onedark = pcall(require, "onedark")
if not status_ok then
  return
end

onedark.setup({
  dark_float = true,
  dark_sidebar = true,
  sidebars = { "Outline" },
  dev = true,
  overrides = function(c)
    return {
      -- Telescope
      TelescopeBorder = {
        fg = c.bg1,
        bg = c.bg1,
      },
      TelescopePromptBorder = {
        fg = c.bg_highlight,
        bg = c.bg_highlight,
      },
      TelescopePromptCounter = { fg = c.fg0 },
      TelescopePromptNormal = { fg = c.fg0, bg = c.bg_highlight },
      TelescopePromptPrefix = {
        fg = c.purple0,
        bg = c.bg_highlight,
      },
      TelescopePromptTitle = {
        fg = c.bg_highlight,
        bg = c.purple0,
      },

      TelescopePreviewTitle = {
        fg = c.bg1,
        bg = c.green0,
      },
      TelescopeResultsTitle = {
        fg = c.bg1,
        bg = c.bg1,
      },

      TelescopeMatching = { fg = c.blue0 },
      TelescopeNormal = { bg = c.bg1 },
      TelescopeSelection = { bg = c.bg_highlight },

      -- CursorWord Highlight
      LspReferenceText = { bg = "#343a45" },
      LspReferenceWrite = { bg = "#343a45" },
      LspReferenceRead = { bg = "#343a45" },
      illuminatedWord = { bg = "#343a45" },
      illuminatedCurWord = { bg = "#343a45" },

      -- DevIcons
      DevIconC = { fg = c.dev_icons.blue },
      DevIconClojure = { fg = c.dev_icons.green0 },
      DevIconCoffee = { fg = c.dev_icons.yellow },
      DevIconCs = { fg = c.dev_icons.blue },
      DevIconCss = { fg = c.dev_icons.blue },
      DevIconMarkdown = { fg = c.dev_icons.blue },
      DevIconGo = { fg = c.dev_icons.blue },
      DevIconHtm = { fg = c.dev_icons.orange },
      DevIconHtml = { fg = c.dev_icons.orange },
      DevIconJava = { fg = c.dev_icons.red },
      DevIconJs = { fg = c.dev_icons.yellow },
      DevIconJson = { fg = c.dev_icons.yellow },
      DevIconLess = { fg = c.dev_icons.yellow },
      DevIconMakefile = { fg = c.dev_icons.orange },
      DevIconMustache = { fg = c.dev_icons.orange },
      DevIconPhp = { fg = c.dev_icons.purple },
      DevIconPython = { fg = c.dev_icons.blue },
      DevIconErb = { fg = c.dev_icons.red },
      DevIconRb = { fg = c.dev_icons.red },
      DevIconSass = { fg = c.dev_icons.pink },
      DevIconScss = { fg = c.dev_icons.pink },
      DevIconSh = { fg = c.dev_icons.gray },
      DevIconSql = { fg = c.dev_icons.pink },
      DevIconTs = { fg = c.dev_icons.blue },
      DevIconXml = { fg = c.dev_icons.orange },
      DevIconYaml = { fg = c.dev_icons.purple },
      DevIconYml = { fg = c.dev_icons.purple },

      -- Cmp
      -- PmenuSel = { bg = c.bg0, fg = c.none },
      -- Pmenu = { fg = c.fg_light, bg = c.bg1 },

      -- CmpItemAbbrDeprecated = { fg = c.fg_gutter, bg = c.none, fmt = "strikethrough" },
      -- CmpItemAbbrMatch = { fg = c.blue0, bg = c.none, fmt = "bold" },
      -- CmpItemAbbrMatchFuzzy = { fg = c.blue0, bg = c.none, fmt = "bold" },
      -- CmpItemMenu = { fg = c.purple0, bg = c.none, fmt = "italic" },

      -- CmpItemKindField = { fg = "#ffffff", bg = c.red1 },
      -- CmpItemKindProperty = { fg = "#ffffff", bg = c.red1 },
      -- CmpItemKindEvent = { fg = "#ffffff", bg = c.red1 },

      -- CmpItemKindText = { fg = "#ffffff", bg = c.green0 },
      -- CmpItemKindEnum = { fg = "#ffffff", bg = c.green0 },
      -- CmpItemKindKeyword = { fg = "#ffffff", bg = c.green0 },

      -- CmpItemKindConstant = { fg = "#ffffff", bg = c.yellow0 },
      -- CmpItemKindConstructor = { fg = "#ffffff", bg = c.yellow0 },
      -- CmpItemKindReference = { fg = "#ffffff", bg = c.yellow0 },

      -- CmpItemKindFunction = { fg = "#ffffff", bg = c.purple0 },
      -- CmpItemKindStruct = { fg = "#ffffff", bg = c.purple0 },
      -- CmpItemKindClass = { fg = "#ffffff", bg = c.purple0 },
      -- CmpItemKindModule = { fg = "#ffffff", bg = c.purple0 },
      -- CmpItemKindOperator = { fg = "#ffffff", bg = c.purple0 },

      -- CmpItemKindVariable = { fg = "#ffffff", bg = c.fg_dark },
      -- CmpItemKindFile = { fg = "#ffffff", bg = c.fg_dark },

      -- CmpItemKindUnit = { fg = "#ffffff", bg = c.orange1 },
      -- CmpItemKindSnippet = { fg = "#ffffff", bg = c.orange1 },
      -- CmpItemKindFolder = { fg = "#ffffff", bg = c.orange1 },

      -- CmpItemKindMethod = { fg = "#ffffff", bg = c.blue1 },
      -- CmpItemKindValue = { fg = "#ffffff", bg = c.blue1 },
      -- CmpItemKindEnumMember = { fg = "#ffffff", bg = c.blue1 },

      -- CmpItemKindInterface = { fg = "#ffffff", bg = c.cyan0 },
      -- CmpItemKindColor = { fg = "#ffffff", bg = c.cyan0 },
      -- CmpItemKindTypeParameter = { fg = "#ffffff", bg = c.cyan0 },
    }
  end,
})

-- vim.cmd("colorscheme onedarkpro")
