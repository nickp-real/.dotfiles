return {
  "echasnovski/mini.nvim",
  lazy = false,
  priority = 1200,
  config = function()
    -- mini.icons
    require("mini.icons").setup()

    -- mini.ai
    local ai = require("mini.ai")
    ai.setup({
      n_lines = 500,
      custom_textobjects = {
        o = ai.gen_spec.treesitter({ -- code block
          a = { "@block.outer", "@conditional.outer", "@loop.outer" },
          i = { "@block.inner", "@conditional.inner", "@loop.inner" },
        }),
        f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
        c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
        t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
        d = { "%f[%d]%d+" }, -- digits
        e = { -- Word with case
          { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
          "^().*()$",
        },
        u = ai.gen_spec.function_call(), -- u for "Usage"
        U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
      },
    })
    -- mini.pairs
    -- require("mini.pairs").setup({ modes = { insert = true, command = true, terminal = false } })

    -- mini.hipatterns
    -- local hi = require("mini.hipatterns")

    -- mini.bufremove
    require("mini.bufremove").setup({
      silent = true,
    })
    vim.keymap.set("n", "<leader>q", function() require("mini.bufremove").delete() end, { desc = "Delete Buffer" })

    -- mini.surround
    require("mini.surround").setup({
      n_lines = 500,
    })
  end,
}
