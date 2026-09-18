return {
  -- Code image
  {
    "narutoxy/silicon.lua",
    keys = {
      {
        "<leader>s",
        function() require("silicon").visualise_api({ to_clip = true }) end,
        mode = "x",
        desc = "Capture code",
      },
    },
    config = true,
  },

  -- Color Toggle
  {
    "brenoprata10/nvim-highlight-colors",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      enable_tailwind = true,
      exclude_filetypes = { "lazy" },
      -- exclude_buftypes = { "nofile" },
    },
  },

  -- http call
  {
    "mistweaverco/kulala.nvim",
    event = { "SessionLoadPost", "VimLeavePre" },
    ft = { "http", "rest", "javascript", "lua" },
    keys = {
      { "<leader>Rr", "", desc = "+Rest" },
      { "<leader>Rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send the request" },
      { "<leader>Rt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body" },
      { "<leader>Rp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Jump to previous request" },
      { "<leader>Rn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request" },
    },
    opts = { treesitter = { enable = false } },
  },

  -- Startuptime
  { "dstein64/vim-startuptime", cmd = "StartupTime" },

  -- Duck over your code!
  {
    "tamton-aquib/duck.nvim",
    keys = {
      { "<leader>mm", function() require("duck").hatch() end, desc = "Summon Duck" },
      { "<leader>mk", function() require("duck").cook() end, desc = "Kill Duck" },
    },
  },

  -- hide secret
  {
    "https://github.com/laytan/cloak.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      cloak_telescope = false,
    },
  },

  -- auto insert log
  {
    "chrisgrieser/nvim-chainsaw",
    event = "VeryLazy",
    keys = {
      { "<leader>lv", function() require("chainsaw").variableLog() end, desc = "[L]og [V]ariable" },
      { "<leader>lo", function() require("chainsaw").objectLog() end, desc = "[L]og [O]bject" },
      { "<leader>lt", function() require("chainsaw").typeLog() end, desc = "[L]og [T]ype" },
      { "<leader>la", function() require("chainsaw").assertLog() end, desc = "[L]og [A]ssert" },
      { "<leader>le", function() require("chainsaw").emojiLog() end, desc = "[L]og [E]moji" },
      { "<leader>lso", function() require("chainsaw").sound() end, desc = "[L]og [So]und" },
      { "<leader>lm", function() require("chainsaw").messageLog() end, desc = "[L]og [M]message" },
      { "<leader>lt", function() require("chainsaw").timeLog() end, desc = "[L]og [T]ime" },
      { "<leader>ld", function() require("chainsaw").debugLog() end, desc = "[L]og [D]ebug" },
      { "<leader>lst", function() require("chainsaw").stacktraceLog() end, desc = "[L]og [S]tack [T]race" },
      { "<leader>lc", function() require("chainsaw").clearLog() end, desc = "[L]og [C]lear" },
      {
        "<leader>lr",
        function() require("chainsaw").removeLogs() end,
        desc = "[L]og [R]emove",
        mode = { "v", "n" },
      },
    },
    opts = {},
  },

  "nvim-lua/plenary.nvim",

  -- Self plugins
  -- Auto insert shebang
  {
    dir = "~/.config/nvim/lua/utils/auto_shebang.nvim",
    ft = { "sh", "bash", "python" },
    config = true,
  },

  -- Code Runner
  {
    dir = "~/.config/nvim/lua/utils/coderunner.nvim",
    cmd = { "Run", "RunUpdate", "AutoRun", "AutoRunCP", "AutoRunClear" },
    config = true,
  },
}
