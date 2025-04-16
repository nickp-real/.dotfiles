local M = {}

M.settings = {
  css = {
    format = {
      spaceAroundSelectorSeparator = true,
    },
    lint = {
      unknownAtRules = "ignore",
    },
  },
}

M.settings.scss = M.settings.css
M.settings.less = M.settings.css

return M
