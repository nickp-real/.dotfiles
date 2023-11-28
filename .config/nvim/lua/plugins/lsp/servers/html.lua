local M = {}

M.settings = {
  html = {
    format = {
      indentHandlebars = true,
      indentInnerHtml = true,
      templating = true,
    },
  },
}

M.filetypes = { "html", "eruby" }

return M
