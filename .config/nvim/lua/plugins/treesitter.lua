local M = {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPost",
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "RRethy/nvim-treesitter-textsubjects",
    "JoosepAlviste/nvim-ts-context-commentstring",
    {
      "andymass/vim-matchup",
      init = function()
        vim.g.matchup_matchparen_offscreen = { method = "popup", border = "rounded" }
      end,
    },
    "p00f/nvim-ts-rainbow",
    {
      "nvim-treesitter/nvim-treesitter-context",
      config = function()
        require("treesitter-context").setup()
      end,
    },
  },
}

function M.config(_, opts)
  require("nvim-treesitter.configs").setup(opts)
end

M.opts = {
  ensure_installed = "all",
  highlight = {
    enable = true,
    disable = { "latex" },
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = { "python", "dart" },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "gni",
      scope_incremental = "gnc",
      node_decremental = "gnm",
    },
  },
  autotag = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = false,
    max_file_lines = nil,
    colors = {
      "#abb2bf", -- bright white
      "#c678dd", -- purple
      -- "#528bff", -- bright blue
      "#61afef", -- blue
      "#98c379", -- green
      "#e5c07b", -- bright yellow
      "#d19a66", -- bright orange
      "#e86671", -- bright red

      -- "#798294", -- white
      -- "#c678dd", -- purple
      -- "#61afef", -- blue
      -- "#98c379", -- green
      -- "#ebd09c", -- yellow
      -- "#e59b4e", -- orange
      -- "#e06c75", --red,

      -- "#e06c75", - red
      -- "#ebd09c", -- yellow
      -- "#e59b4e", -- orange
      -- "#98c379", -- green
      -- "#61afef", -- blue
      -- "#56b6c2", -- cyan
      -- "#c678dd", -- purple
    },
  },
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
        ["uc"] = "@comment.outer",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>sa"] = "@parameter.inner",
        ["<leader>sf"] = "@function.outer",
        ["<leader>se"] = "@element",
      },
      swap_previous = {
        ["<leader>sA"] = "@parameter.inner",
        ["<leader>sF"] = "@function.outer",
        ["<leader>sE"] = "@element",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]f"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]a"] = "@parameter.outer",
      },
      goto_next_end = {
        ["]F"] = "@function.outer",
        ["]["] = "@class.outer",
        ["]A"] = "@parameter.outer",
      },
      goto_previous_start = {
        ["[f"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[a"] = "@parameter.outer",
      },
      goto_previous_end = {
        ["[F"] = "@function.outer",
        ["[]"] = "@class.outer",
        ["[A"] = "@parameter.outer",
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
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  matchup = {
    enable = true,
  },
}

return M
