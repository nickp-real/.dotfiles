return {
  -- Smooth Scroll
  {
    "declancm/cinnamon.nvim",
    event = "BufReadPost",
    opts = {
      extra_keymap = true,
      exteded_keymap = true,
      -- override_keymap = true,
    },
  },

  -- Tmux integration
  {
    "aserowy/tmux.nvim",
    event = "VeryLazy",
    keys = {
      -- navigation
      { "<A-h>", "<cmd>lua require('tmux').move_left()<cr>" },
      { "<A-j>", "<cmd>lua require('tmux').move_bottom()<cr>" },
      { "<A-k>", "<cmd>lua require('tmux').move_top()<cr>" },
      { "<A-l>", "<cmd>lua require('tmux').move_right()<cr>" },

      -- resize
      { "<A-Up>", "<cmd>lua require('tmux').resize_top()<cr>" },
      { "<A-Down>", "<cmd>lua require('tmux').resize_bottom()<cr>" },
      { "<A-Left>", "<cmd>lua require('tmux').resize_left()<cr>" },
      { "<A-Right>", "<cmd>lua require('tmux').resize_right()<cr>" },
    },
    opts = {
      copy_sync = {
        sync_clipboard = true,
      },
      navigation = {
        -- enables default keybindings (C-hjkl) for normal mode
        enable_default_keybindings = false,
      },
      resize = {
        -- enables default keybindings (A-hjkl) for normal mode
        enable_default_keybindings = false,

        -- sets resize steps for x axis
        resize_step_x = 10,

        -- sets resize steps for y axis
        resize_step_y = 10,
      },
    },
  },

  -- Code image
  {
    "krivahtoo/silicon.nvim",
    build = "./install.sh build",
    name = "silicon",
    cmd = "Silicon",
    config = function(_, opts)
      require("silicon").setup(opts)
    end,
    opts = {
      font = "Roboto Mono=14",
    },
  },

  -- Color Toggle
  {
    "NvChad/nvim-colorizer.lua",
    cmd = "Colorizer",
    keys = { { "<leader>tc", vim.cmd.ColorizerToggle, desc = "Toggle Colorizer" } },
    opts = {
      filetypes = {
        "*",
        "!packer",
        "!lazy",
      },
      buftype = { "*", "!prompt", "!nofile" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        virtualtext = "■",
      },
    },
  },

  -- Float Terminal
  {
    "numToStr/FTerm.nvim",
    keys = {
      { "<C-_>", "<cmd>lua require('FTerm').toggle()<cr>", desc = "Open Float Terminal" },
      { "<C-_>", "<C-\\><C-n><cmd>lua require('FTerm').toggle()<cr>", mode = "t", desc = "Open Float Terminal" },
    },
    init = function()
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "FTerm",
        callback = function()
          vim.opt_local.spell = false
        end,
      })
    end,
    opts = {
      border = "rounded",
      hl = "NormalFloat",
    },
  },

  -- Jump in buffer
  {
    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    cmd = { "HopChar1", "HopWord" },
    keys = {
      { "s", ":HopChar1<cr>", desc = "Hop 1 Char" },
      { "S", ":HopWord<cr>", desc = "Hop word" },
    },
    opts = { keys = "etovxqpdygfblzhckisuran" },
  },

  -- Discord Presence
  { "andweeb/presence.nvim", event = "VeryLazy" },

  -- Symbols Outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>so", "<cmd>SymbolsOutline<cr>", desc = "Symbol Outline" } },
    config = true,
  },

  -- Startuptime
  { "dstein64/vim-startuptime", cmd = "StartupTime" },

  -- Better bd
  { "famiu/bufdelete.nvim", cmd = "Bdelete", keys = { { "<C-c>", "<cmd>Bdelete<cr>" } } },

  -- Resize buffer
  { "kwkarlwang/bufresize.nvim", event = "BufReadPost", config = true },

  -- mkdir when not available
  { "jghauser/mkdir.nvim", event = "BufRead" },

  -- Swap the split
  {
    "xorid/swap-split.nvim",
    cmd = "SwapSplit",
    keys = { { "<leader>sp", "<cmd>SwapSplit<cr>", desc = "Swap Split" } },
  },
  -- Duck over your code!
  {
    "tamton-aquib/duck.nvim",
    keys = {
      { "<leader>mm", "<cmd>lua require('duck').hatch()<cr>", desc = "Summon Duck" },
      { "<leader>mk", "<cmd>lua require('duck').cook()<cr>", desc = "Kill Duck" },
    },
  },

  -- At import cost on your js, jsx, ts, tsx file
  {
    "barrett-ruth/import-cost.nvim",
    build = "sh install.sh npm",
    config = true,
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },

  -- Auto nohl
  {
    "asiryk/auto-hlsearch.nvim",
    keys = {
      "/",
      "?",
      "*",
      "#",
      { "n", "nzzzv<cmd>lua require('auto-hlsearch').activate()<cr>" },
      { "N", "Nzzzv<cmd>lua require('auto-hlsearch').activate()<cr>" },
    },
    opts = { remap_keys = { "/", "?", "*", "#" } },
  },

  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
}
