return {
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",
  "MunifTanjim/nui.nvim",

  -- Icon
  "nvim-tree/nvim-web-devicons",

  -- Log Highlight
  { "MTDL9/vim-log-highlighting", ft = "log" },

  --------
  -- UI --
  --------
  {
    "folke/todo-comments.nvim",
    event = "BufReadPre",
    config = true,
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous todo comment",
      },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo Trouble" },
      { "<leader>xtt", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo Trouble" },
      { "<leader>xT", "<cmd>TodoTelescope<cr>", desc = "Todo Telescope" },
    },
  },
  {
    "m-demare/hlargs.nvim",
    event = "BufReadPre",
    opts = { color = "#e59b4e" },
  },

  ---------
  -- LSP --
  ---------
  -- "ray-x/lsp_signature.nvim",
  "mrshmllow/document-color.nvim",
  "b0o/SchemaStore.nvim",
  "jose-elias-alvarez/typescript.nvim",
  "williamboman/mason-lspconfig.nvim",

  {
    "lvimuser/lsp-inlayhints.nvim",
    config = true,
  },
  -- Java
  { "mfussenegger/nvim-jdtls", ft = "java" },

  ---------------
  -- LSP Addon --
  ---------------
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    config = true,
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Trouble Toggle" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble Workspace" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble Document" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble Quickfix" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Trouble Loclist" },
      { "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", desc = "Trouble LSP" },
    },
  },
  -- ({
  --   "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  --   config = function()
  --     require("lsp_lines").setup()
  --   end,
  -- })
  -- ("mfussenegger/nvim-lint")

  -------------
  -- Editing --
  -------------
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = "Neogen",
    keys = { { "<leader>n", "<cmd>Neogen<cr>", desc = "Neogen" } },
    opts = { snippet_engine = "luasnip" },
  },
  {
    "kylechui/nvim-surround",
    keys = { "cs", "ds", "ys", "yS", { "S", mode = "x" }, { "gS", mode = "x" } },
    config = true,
  },
  {
    "mizlan/iswap.nvim",
    cmd = "ISwap",
    keys = { { "<leader>sw", "<cmd>ISwap<cr>", desc = "Swap Param" } },
    opts = { autoswap = true },
  },
  {
    "Wansmer/treesj",
    cmd = "TSJToggle",
    keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Split & Join" } },
    opts = { use_default_keymaps = false },
  },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
    },
  },

  ---------------
  -- Previewer --
  ---------------

  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = "cd app && yarn install",
    cmd = "MarkdownPreview",
  },

  -- HTML
  {
    "turbio/bracey.vim",
    ft = "html",
    build = "npm install --prefix server",
    init = function()
      vim.g.bracey_refresh_on_save = 1
    end,
  },

  -- LaTex
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_view_method = "zathura"
    end,
  },

  -------------
  -- Utility --
  -------------
  -- Discord Presence
  { "andweeb/presence.nvim", event = "VeryLazy" },
  -- Symbols Outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = {
      { "<leader>so", "<cmd>SymbolsOutline<cr>", desc = "Symbol Outline" },
    },
    config = true,
  },
  -- Startuptime
  { "dstein64/vim-startuptime", cmd = "StartupTime" },

  { "famiu/bufdelete.nvim", cmd = "Bdelete", keys = { { "<C-c>", "<cmd>Bdelete<cr>" } } },
  {
    "kwkarlwang/bufresize.nvim",
    event = "BufReadPost",
    config = true,
  },
  {
    "jghauser/mkdir.nvim",
    event = "BufRead",
  },

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
    opts = {
      remap_keys = { "/", "?", "*", "#" },
    },
  },
}
