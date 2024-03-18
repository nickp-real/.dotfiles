local root_pattern = require("lspconfig.util").root_pattern

local M = {}

M.init_options = {
  userLanguages = {
    eelixir = "html-eex",
    eruby = "erb",
  },
}

M.on_attach = function(client, bufnr) require("tailwind-sorter") end

M.settings = {
  tailwindCSS = {
    experimental = {
      classRegex = {
        "tw`([^`]*)",
        'tw="([^"]*)',
        'tw={"([^"}]*)',
        "tw\\.\\w+`([^`]*)",
        "tw\\(.*?\\)`([^`]*)",
        { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
        { "classnames\\(([^)]*)\\)", "'([^']*)'" },
        { "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
        { "cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
      },
    },
  },
}

M.root_dir = {
  "tailwind.config.js",
  "tailwind.config.ts",
  "tailwind.config.cjs",
  "./config/tailwind.config.js",
  "tailwind.config.mjs",
}

M.root_dir = root_pattern(unpack(M.root_dir))

return M
