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
  },
  {
    "m-demare/hlargs.nvim",
    event = "BufReadPre",
    config = { color = "#e59b4e" },
  },

  ---------
  -- LSP --
  ---------
  "ray-x/lsp_signature.nvim",
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
    cmd = "Neogen",
    config = { snippet_engine = "luasnip" },
  },
  {
    "kylechui/nvim-surround",
    keys = { "cs", "ds", "ys", "yS", "ySS", { "S", mode = "x" }, { "gS", mode = "x" } },
    config = true,
  },
  {
    "mizlan/iswap.nvim",
    cmd = "ISwap",
    config = { autoswap = true },
  },
  {
    "Wansmer/treesj",
    cmd = "TSJToggle",
    config = { use_default_keymaps = false },
  },
  { "mbbill/undotree", cmd = "UndotreeToggle" },

  ---------------
  -- Previewer --
  ---------------

  -- Markdown

  { "ellisonleao/glow.nvim", ft = "markdown" },
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
    config = function()
      vim.g.bracey_refresh_on_save = 1
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
    config = true,
  },
  -- Startuptime
  { "dstein64/vim-startuptime", cmd = "StartupTime" },

  { "famiu/bufdelete.nvim", cmd = "Bdelete" },
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
  { "xorid/swap-split.nvim", cmd = "SwapSplit" },
  -- Duck over your code!
  "tamton-aquib/duck.nvim",
}
