return {
  -- Discord
  {
    "vyfor/cord.nvim",
    build = ":Cord update",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },

  -- Wakatime
  { "wakatime/vim-wakatime", event = { "BufReadPre", "BufNewFile" } },
}
