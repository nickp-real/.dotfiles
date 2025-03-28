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
    ft = "http",
    keys = {
      { "<leader>R", "", desc = "+Rest" },
      { "<leader>Rs", "<cmd>lua require('kulala').run()<cr>", desc = "Send the request" },
      { "<leader>Rt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body" },
      { "<leader>Rp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Jump to previous request" },
      { "<leader>Rn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request" },
    },
    config = true,
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

  -- At import cost on your js, jsx, ts, tsx file
  {
    "barrett-ruth/import-cost.nvim",
    build = "sh install.sh npm",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "svelte",
        "astro",
      },
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
    dependencies = { "FTerm.nvim" },
    cmd = { "Run", "RunUpdate", "AutoRun", "AutoRunCP", "AutoRunClear" },
    config = true,
  },
}
