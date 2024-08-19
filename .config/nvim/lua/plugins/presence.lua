return {
  -- Discord
  {
    "vyfor/cord.nvim",
    build = "./build",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- Wakatime
  { "wakatime/vim-wakatime", event = { "BufReadPre", "BufNewFile" } },
}
