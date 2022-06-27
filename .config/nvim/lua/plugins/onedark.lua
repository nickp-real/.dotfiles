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
    }
  end,
})
