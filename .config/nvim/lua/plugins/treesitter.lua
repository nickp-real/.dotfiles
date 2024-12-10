return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
  lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
  init = function(plugin)
    require("lazy.core.loader").add_to_rtp(plugin)
    require("nvim-treesitter.query_predicates")
  end,
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    {
      "andymass/vim-matchup",
      init = function() vim.g.matchup_matchparen_offscreen = { method = "popup", border = vim.g.border } end,
    },
    { "nvim-treesitter/nvim-treesitter-context", opts = { max_lines = 3, separator = "━" } },
  },
  config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
  opts = {
    ensure_installed = "all",
    ignore_install = { "comment" },
    highlight = {
      enable = true,
      disable = { "latex" },
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
      disable = { "python" },
    },
    incremental_selection = {
      enable = false,
      keymaps = {
        init_selection = "<cr>",
        node_incremental = "<cr>",
        scope_incremental = "<S-CR>",
        node_decremental = "<bs>",
      },
    },
    textobjects = {
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
      lsp_interop = {
        enable = true,
        border = vim.g.border,
        floating_preview_opts = {},
        peek_definition_code = {
          ["<leader>df"] = "@function.outer",
          ["<leader>dF"] = "@class.outer",
        },
      },
    },
    matchup = { enable = true, enable_quotes = true },
  },
}
