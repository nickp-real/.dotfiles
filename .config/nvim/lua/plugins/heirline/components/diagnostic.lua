local conditions = require("heirline.conditions")
local icon = vim.g.signs

local diagnostic = {
  condition = conditions.has_diagnostics,
  static = {
    error_icon = icon.Error,
    warn_icon = icon.Warn,
    info_icon = icon.Info,
    hint_icon = icon.Hint,
  },
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  update = { "DiagnosticChanged", "BufReadPre" },
  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      return self.errors > 0 and (self.error_icon .. self.errors .. " ")
    end,
    hl = { fg = "red" },
  },
  {
    provider = function(self) return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ") end,
    hl = { fg = "yellow" },
  },
  {
    provider = function(self) return self.info > 0 and (self.info_icon .. self.info .. " ") end,
    hl = { fg = "blue" },
  },
  {
    provider = function(self) return self.hints > 0 and (self.hint_icon .. self.hints) end,
    hl = { fg = "cyan" },
  },
}

return diagnostic
