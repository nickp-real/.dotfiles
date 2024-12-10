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

---@alias keyMode "v"| "n" | "i" | "x" | "c" | "o"

---@class KeySpec
---@field [1] string
---@field [2] (string | function)?
---@field mode (keyMode[] | keyMode)?
---@field desc string?

---@class LoadOnKeyArgs
---@field module string
---@field opts (table | fun(): table)?
---@field keys KeySpec[] | fun(opts: table): KeySpec[]

---@param spec LoadOnKeyArgs
local function load_on_key(spec)
  local keys, module, opts = spec.keys, spec.module, spec.opts
  local resolved_opts = type(opts) == "function" and opts() or opts or {} --[[@as table]]
  local resolved_keys = type(keys) == "function" and keys(resolved_opts) or keys --[=[@as KeySpec[]]=]

  for _, key_opts in ipairs(resolved_keys) do
    local key, mode, cb, desc = key_opts[1], key_opts.mode or "n", key_opts[2], key_opts.desc

    vim.keymap.set(mode, key, function()
      if not package.loaded[module] then
        if not cb then vim.keymap.del(mode, key) end
        require(module).setup(resolved_opts)
      end

      if not cb then -- plugin handle
        local feed = vim.api.nvim_replace_termcodes("<Ignore>" .. key, true, true, true)
        vim.api.nvim_feedkeys(feed, "i", false)
        print("feed")
      else
        cb()
      end
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
      end)

      -- mini.bufremove
      load_on_key({
        keys = { { "<leader>q", function() require("mini.bufremove").delete() end, desc = "Delete Buffer" } },
        module = "mini.bufremove",
        opts = { silent = true },
      })

      -- mini.splitjoin
      load_on_key({
        keys = { { "J", function() require("mini.splitjoin").toggle() end, desc = "Split Join" } },
        module = "mini.splitjoin",
        opts = function()
          local gen_hook = require("mini.splitjoin").gen_hook
          local curly = { brackets = { "%b{}" } }

          -- Add trailing comma when splitting inside curly brackets
          local add_comma_curly = gen_hook.add_trailing_separator(curly)

          -- Delete trailing comma when joining inside curly brackets
          local del_comma_curly = gen_hook.del_trailing_separator(curly)

          -- Pad curly brackets with single space after join
          local pad_curly = gen_hook.pad_brackets(curly)

          return {
            mappings = { toggle = "" },
            split = { hooks_post = { add_comma_curly } },
            join = { hooks_post = { del_comma_curly, pad_curly } },
          }
        end,
      })

      -- mini.surround
      load_on_key({
        keys = function(opts)
          local mode = { "v", "n" }
          return {
            { opts.mappings.add, desc = "Add surrounding in Normal and Visual modes", mode = mode },
            { opts.mappings.delete, desc = "Delete surrounding", mode = mode },
            { opts.mappings.find, desc = "Find surrounding (to the right)", mode = mode },
            { opts.mappings.find_left, desc = "Find surrounding (to the left)", mode = mode },
            { opts.mappings.highlight, desc = "Highlight surrounding ", mode = mode },
            { opts.mappings.replace, desc = "Replace surrounding", mode = mode },
            { opts.mappings.update_n_lines, desc = "Update `n_lines`", mode = mode },
          }
        end,
        module = "mini.surround",
        opts = {
          mappings = {
            add = "sa",
            delete = "sd",
            find = "sf",
            find_left = "sF",
            highlight = "sh",
            replace = "sr",
            update_n_lines = "sn",
          },
        },
      })
    end,
  },
}
