---@param cb function
local function load_on_lazy(cb)
  local group = vim.api.nvim_create_augroup("Mini_VeryLazy", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    desc = "Load mini plugins on lazy",
    pattern = "VeryLazy",
    group = group,
    callback = cb,
  })
end

---@alias keyMode "v"| "n" | "i" | "x"

---@class KeySpec
---@field [1] string
---@field [2] string | function
---@field mode (keyMode[] | keyMode)?
---@field desc string?

---@class LoadOnKeyArgs
---@field module string
---@field opts table
---@field keys KeySpec[]

---@param t LoadOnKeyArgs
local function load_on_key(t)
  local keys, module, opts = t.keys, t.module, t.opts
  local is_loaded = false

  for _, key_opts in ipairs(keys) do
    local key, mode, cb, desc = key_opts[1], key_opts.mode, key_opts[2], key_opts.desc

    vim.keymap.set(mode or "n", key, function()
      if not is_loaded then
        require(module).setup(opts)
        is_loaded = true
      end
      cb()
    end, { desc = desc })
  end
end

return {
  {
    "echasnovski/mini.nvim",
    lazy = false,
    config = function()
      load_on_lazy(function()
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
        require("mini.pairs").setup({ modes = { insert = true, command = true, terminal = false } })

        load_on_key({
          keys = { { "<leader>q", function() require("mini.bufremove").delete() end, desc = "Delete Buffer" } },
          module = "mini.bufremove",
          opts = { silent = true },
        })
      end)
    end,
  },
}
