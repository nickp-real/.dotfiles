return {
  -- Auto pair
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      disable_filetype = { "TelescopePrompt", "vim" },
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      fast_wrap = {},
      enable_check_bracket_line = false,
    },
  },

  -- Auto tag
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = true,
  },

  -- Surround pair
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = true,
  },

  -- Comment
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = { lang = { prisma = "// %s" } },
  },

  -- Toggle between word
  {
    "monaqa/dial.nvim",
    keys = function()
      return {
        {
          "<C-a>",
          function() return require("dial.map").inc_normal() end,
          desc = "Increment",
          expr = true,
          mode = { "n", "v" },
        },
        {
          "<C-x>",
          function() return require("dial.map").dec_normal() end,
          desc = "Decrement",
          expr = true,
          mode = { "n", "v" },
        },
        {
          "g<C-a>",
          function() return require("dial.map").inc_gvisual() end,
          desc = "Gvisual Increment",
          expr = true,
          mode = "v",
        },
        {
          "g<C-x>",
          function() return require("dial.map").dec_gvisual() end,
          desc = "Gvisual Decrement",
          expr = true,
          mode = "v",
        },
      }
    end,
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.constant.new({ elements = { "let", "const" } }),
        },
      })
    end,
  },

  -- Tabout
  {
    "abecodes/tabout.nvim",
    opts = {
      act_as_shift_tab = true,
      tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
        { open = '["', close = '"]' },
      },
    },
  },

  -- Template string for js, jsx, ts, tsx
  {
    "axelvc/template-string.nvim",
    event = "InsertEnter",
    opts = {
      remove_template_string = true, -- remove backticks when there are no template string
      restore_quotes = {
        -- quotes used when "remove_template_string" option is enabled
        normal = [["]],
        jsx = [["]],
      },
    },
  },

  -- Split & Join
  {
    "Wansmer/treesj",
    keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Split & Join" } },
    opts = { use_default_keymaps = false },
  },
}
