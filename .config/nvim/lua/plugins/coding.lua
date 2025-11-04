return {
  -- Auto pair
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      disable_filetype = { "vim" },
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

  -- Toggle between word
  {
    "monaqa/dial.nvim",
    keys = {
      {
        "<C-a>",
        function() return require("dial.map").inc_normal() end,
        desc = "Increment",
        expr = true,
        mode = { "n", "v" },
      },
      {
        "<C-x>",
        function() require("dial.map").dec_normal() end,
        desc = "Decrement",
        expr = true,
        mode = { "n", "v" },
      },
      {
        "g<C-a>",
        function() require("dial.map").manipulate("increment", "gvisual") end,
        desc = "Gvisual Increment",
        expr = true,
        mode = "x",
      },
      {
        "g<C-x>",
        function() require("dial.map").manipulate("decrement", "gvisual") end,
        desc = "Gvisual Decrement",
        expr = true,
        mode = "x",
      },
    },
    opts = function()
      local augend = require("dial.augend")

      local logical_alias = augend.constant.new({
        elements = { "&&", "||" },
        word = false,
        clclic = true,
      })

      local ordinal_number = augend.constant.new({
        elements = {
          "first",
          "second",
          "third",
          "fourth",
          "fifth",
          "sixth",
          "seventh",
          "eight",
          "ninth",
          "tenth",
        },
        word = false,
        cyclic = true,
      })

      local weekdays = augend.constant.new({
        elements = {
          "Monday",
          "Tuesday",
          "Wednesday",
          "Thursday",
          "Friday",
          "Saturday",
          "Sunday",
        },
      })

      local months = augend.constant.new({
        elements = {
          "January",
          "February",
          "March",
          "April",
          "May",
          "June",
          "July",
          "August",
          "September",
          "October",
          "November",
          "December",
        },
      })

      local capitalized_boolean = augend.constant.new({
        elements = { "True", "False" },
      })

      local dials_by_ft = {
        css = "css",
        vue = "vue",
        javascript = "typescript",
        typescript = "typescript",
        typescriptreact = "typescript",
        javascriptreact = "typescript",
        json = "json",
        lua = "lua",
        markdown = "markdown",
        sass = "css",
        scss = "css",
        python = "python",
      }

      local dials_js = { augend.constant.new({ elements = { "let", "const" } }) }
      local dials_hex = { augend.hexcolor.new({ case = "lower" }), augend.hexcolor.new({ case = "upper" }) }

      local dials_readable_boolean = { augend.constant.new({ elements = { "and", "or" } }) }

      local dials_groups = {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.decimal_int,
          ordinal_number,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          capitalized_boolean,
          logical_alias,
          augend.semver.alias.semver,
          weekdays,
          months,
        },
        vue = vim.iter({ dials_js, dials_hex }):flatten():totable(),
        typescript = dials_js,
        css = dials_hex,
        markdown = { augend.misc.alias.markdown_header },
        json = { augend.semver.alias.semver },
        lua = dials_readable_boolean,
        python = dials_readable_boolean,
      }

      return {
        dials_by_ft = dials_by_ft,
        groups = dials_groups,
      }
    end,
    config = function(_, opts)
      for name, group in pairs(opts.groups) do
        if name ~= "default" then vim.list_extend(group, opts.groups.default) end
        require("dial.config").augends:register_group(opts.groups)
        vim.g.dials_by_ft = opts.dials_by_ft
      end
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
}
