return {
  -- Smooth Scroll
  {
    "declancm/cinnamon.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      extra_keymap = true,
      exteded_keymap = true,
      -- override_keymap = true,
    },
  },

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
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      render = "background",
      enable_tailwind = true,
      exclude_filetypes = { "lazy" },
      -- exclude_buftypes = { "nofile" },
    },
  },

  -- Float Terminal
  -- TODO: change FTerm.nvim to require("lazy.util").float_term({cmd}, {opts, border = "rounded"})
  {
    "numToStr/FTerm.nvim",
    keys = {
      -- { "<C-_>", "<cmd>lua require('FTerm').toggle()<cr>", desc = "Open Float Terminal" },
      { "<C-_>", "<C-\\><C-n><cmd>lua require('FTerm').toggle()<cr>", mode = "t", desc = "Open Float Terminal" },
    },
    init = function()
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "FTerm",
        callback = function() vim.opt_local.spell = false end,
      })
    end,
    opts = {
      border = vim.g.border,
      hl = "NormalFloat",
    },
  },

  -- http call
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      { "vhyrro/luarocks.nvim", opts = {} },
    },
    ft = "http",
    keys = {
      { "<leader>hr", "<Plug>RestNvim", desc = "Run request under cursor" },
      { "<leader>hp", "<Plug>RestNvimPreview", desc = "Preview request curl command" },
      { "<leader>hl", "<Plug>RestNvimLast", desc = "Re-run last request" },
    },
    config = function() require("rest-nvim").setup() end,
  },

  -- Discord Presence
  { "andweeb/presence.nvim", event = { "BufReadPre", "BufNewFile" } },

  -- Startuptime
  { "dstein64/vim-startuptime", cmd = "StartupTime" },

  -- Better bd
  {
    "famiu/bufdelete.nvim",
    cmd = "Bdelete",
    keys = { { "<leader>q", "<cmd>Bdelete<cr>", desc = "Delete Buffer" } },
  },

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
    build = "sh install.sh pnpm",
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

  -- Auto nohl
  { "nvimdev/hlsearch.nvim", event = "BufReadPost", config = true },

  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",

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

  -- Wakatime
  { "wakatime/vim-wakatime", event = { "BufReadPre", "BufNewFile" } },
}
