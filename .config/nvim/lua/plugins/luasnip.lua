local M = {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}

function M.config(_, opts)
  local luasnip = require("luasnip")

  luasnip.setup(opts)

  luasnip.snippets = {
    all = {},
    html = {},
  }

  -- enable html snippets in javascript/typescript (REACT)
  luasnip.filetype_extend("javascriptreact", { "html" })
  luasnip.filetype_extend("typescriptreact", { "html" })

  luasnip.filetype_extend("dart", { "flutter" })
  luasnip.add_snippets("cpp", require("snippet.cpp"))
end

M.opts = {
  history = true,
  update_events = "InsertLeave,TextChanged,TextChangedI",
  region_check_events = "CursorHold,InsertLeave,InsertEnter",
  delete_check_events = "TextChanged,InsertEnter",
  enable_autosnippets = true,
}

return M
