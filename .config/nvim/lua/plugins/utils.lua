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
      { "<Leader>s", function() require("silicon").visualise_api({ to_clip = true }) end, mode = { "x" } },
    },
    opts = { font = "ComicShannsMono Nerd Font" },
  },

  -- Color Toggle
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    cmd = "Colorizer",
    keys = { { "<leader>tc", vim.cmd.ColorizerToggle, desc = "Toggle Colorizer" } },
    opts = {
      filetypes = {
        "*",
        "!packer",
        "!lazy",
        "!log",
      },
      buftypes = { "*", "!prompt", "!terminal" },
      user_default_options = {
        names = false,
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = true, -- 0xAARRGGBB hex codes
        rgb_fn = true,
        hsl_fn = true,
        tailwind = "both",
      },
    },
  },

  -- Float Terminal
  -- TODO: change FTerm.nvim to require("lazy.util").float_term({cmd}, {opts, border = "rounded"})
  {
    "numToStr/FTerm.nvim",
    keys = {
      { "<C-_>", "<cmd>lua require('FTerm').toggle()<cr>", desc = "Open Float Terminal" },
      { "<C-_>", "<C-\\><C-n><cmd>lua require('FTerm').toggle()<cr>", mode = "t", desc = "Open Float Terminal" },
    },
    init = function()
      vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "FTerm",
        callback = function() vim.opt_local.spell = false end,
      })
    end,
    opts = {
      border = require("core.styles").border,
      hl = "NormalFloat",
    },
  },

  -- Session Manager
  {
    "Shatur/neovim-session-manager",
    cmd = "SessionManager",
    event = "BufReadPre",
    config = function(_, opts) require("session_manager").setup(opts) end,
    keys = {
      { "<leader>sl", "<cmd>SessionManager load_last_session<cr>", desc = "Load Last Session" },
      { "<leader>sn", "<cmd>SessionManager load_session<cr>", desc = "View All Session" },
    },
    opts = function()
      return {
        sessions_dir = require("plenary.path"):new(vim.fn.stdpath("data"), "sessions"), -- The directory where the session files will be saved.
        path_replacer = "__", -- The character to which the path separator will be replaced for session files.
        colon_replacer = "++", -- The character to which the colon symbol will be replaced for session files.
        autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
        autosave_last_session = true, -- Automatically save last session on exit and on session switch.
        autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
        autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
          "gitcommit",
          "gitrebase",
        },
        autosave_only_in_session = true, -- Always autosaves session. If true, only autosaves after a session is active.
      }
    end,
  },

  -- http call
  {
    "rest-nvim/rest.nvim",
    ft = "http",
    keys = {
      { "<leader>hr", "<Plug>RestNvim", desc = "Run request under cursor" },
      { "<leader>hp", "<Plug>RestNvimPreview", desc = "Preview request curl command" },
      { "<leader>hl", "<Plug>RestNvimLast", desc = "Re-run last request" },
    },
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
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte", "astro" },
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
