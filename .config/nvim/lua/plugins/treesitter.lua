return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
  build = ":TSUpdate",
  keys = {
    {
      ";",
      mode = { "n", "x", "o" },
      function() require("nvim-treesitter.textobjects.repeatable_move").repeat_last_move_next() end,
      desc = "TS Repeat Last Move",
    },
    {
      ",",
      mode = { "n", "x", "o" },
      function() require("nvim-treesitter.textobjects.repeatable_move").repeat_last_move_previous() end,
      desc = "TS Repeat Last Move",
    },
  },
  dependencies = {
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "RRethy/nvim-treesitter-textsubjects",
    {
      "andymass/vim-matchup",
      init = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup", border = require("core.styles").border }
      end,
    },
    { "nvim-treesitter/nvim-treesitter-context", opts = { max_lines = 3 } },
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
      enable = true,
      keymaps = {
        init_selection = "<cr>",
        node_incremental = "<cr>",
        scope_incremental = "<S-CR>",
        node_decremental = "<bs>",
      },
    },
    autotag = { enable = true },
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["ai"] = "@conditional.outer",
          ["ii"] = "@conditional.inner",
          ["at"] = "@comment.outer",
          ["it"] = "@comment.inter",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>a"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>A"] = "@parameter.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]f"] = "@function.outer",
          ["]c"] = "@class.outer",
          ["]a"] = "@parameter.outer",
          ["]o"] = "@loop.*",
        },
        goto_next_end = {
          ["]F"] = "@function.outer",
          ["]C"] = "@class.outer",
          ["]A"] = "@parameter.outer",
        },
        goto_previous_start = {
          ["[f"] = "@function.outer",
          ["[c"] = "@class.outer",
          ["[a"] = "@parameter.outer",
        },
        goto_previous_end = {
          ["[F"] = "@function.outer",
          ["[C"] = "@class.outer",
          ["[A"] = "@parameter.outer",
        },
        goto_next = {
          ["]i"] = "@conditional.outer",
        },
        goto_previous = {
          ["[i"] = "@conditional.outer",
        },
      },
      lsp_interop = {
        enable = true,
        border = require("core.styles").border,
        floating_preview_opts = {},
        peek_definition_code = {
          ["<leader>df"] = "@function.outer",
          ["<leader>dF"] = "@class.outer",
        },
      },
    },
    textsubjects = {
      enable = true,
      prev_selection = ",", -- (Optional) keymap to select the previous selection
      keymaps = {
        ["."] = "textsubjects-smart",
        [";"] = "textsubjects-container-outer",
        ["i;"] = "textsubjects-container-inner",
      },
    },
    matchup = { enable = true, enable_quotes = true },
  },
}
