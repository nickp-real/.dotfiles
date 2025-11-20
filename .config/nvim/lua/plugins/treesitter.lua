return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    build = ":TSUpdate",
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    dependencies = {
      {
        "andymass/vim-matchup",
        init = function() vim.g.matchup_matchparen_offscreen = { method = "popup", border = vim.g.border } end,
      },
      { "nvim-treesitter/nvim-treesitter-context", opts = { max_lines = 4, trim_scope = "inner", separator = "━" } },
    },
    config = function(_, opts)
      local ts = require("nvim-treesitter")
      ts.setup(opts)

      local already_installed = ts.get_installed()
      local to_install = vim
        .iter(opts.ensure_installed)
        :filter(function(parser) return not vim.tbl_contains(already_installed, parser) end)
        :totable()

      if #to_install > 0 then ts.install(to_install) end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_filetype", { clear = true }),
        callback = function(ev)
          local ft, lang = ev.match, vim.treesitter.language.get_lang(ev.match)
          if not vim.tbl_contains(opts.ensure_installed, ft) and not vim.tbl_contains(opts.ensure_installed, lang) then
            return
          end

          pcall(vim.treesitter.start, ev.buf)
          vim.api.nvim_set_option_value(
            "indentexpr",
            "v:lua.require'nvim-treesitter'.indentexpr()",
            { scope = "local" }
          )
        end,
      })
    end,
    opts = {
      ensure_installed = {
        "fish",
        "bash",
        "diff",
        "lua",
        "luadoc",
        "html",
        "typescript",
        "tsx",
        "javascript",
        "jsx",
        "jsdoc",
        "ecma",
        "php",
        "sql",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "json",
        "jsonc",
        "yaml",
        "prisma",
        "make",
        "tmux",
        "hyprlang",
        "qmljs",
        "qmldir",
        "ini",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    config = function(_, opts)
      require("nvim-treesitter-textobjects").setup(opts)
      local ts = require("nvim-treesitter")
      local ts_installed = ts.get_installed()

      ---@param buf integer
      local function attach(buf)
        local ft = vim.bo[buf].filetype
        local ts_ft = vim.treesitter.language.get_lang(ft)
        if not vim.tbl_contains(ts_installed, ft) and not vim.tbl_contains(ts_installed, ts_ft) then return end
        local moves = vim.tbl_get(opts, "move", "keys") or {}

        for method, keymaps in pairs(moves) do
          for key, query in pairs(keymaps) do
            local desc = {}
            for word in method:gmatch("%a+") do
              table.insert(desc, word)
            end

            local object = query:gsub("@", ""):gsub("%..*", "")
            table.insert(desc, object)
            -- capitalize
            desc = vim.tbl_map(function(word) return word:sub(1, 1):upper() .. word:sub(2) end, desc)

            vim.keymap.set(
              { "n", "x", "o" },
              key,
              function() require("nvim-treesitter-textobjects.move")[method](query, "textobjects") end,
              { buffer = buf, silent = true, desc = table.concat(desc, " ") }
            )
          end
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_textobjects_blind", { clear = true }),
        callback = function(ev) attach(ev.buf) end,
      })

      vim.tbl_map(attach, vim.api.nvim_list_bufs())
    end,
    opts = {
      move = {
        set_jumps = true,
        keys = {
          goto_next_start = { ["]f"] = "@function.outer" },
          goto_next_end = { ["]F"] = "@function.outer" },
          goto_previous_start = { ["[f"] = "@function.outer" },
          goto_previous_end = { ["[F"] = "@function.outer" },
          goto_next = {},
          goto_previous = {},
        },
      },
    },
  },

  -- Auto tag
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },

  -- Comment
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = { lang = { prisma = "// %s" } },
  },
}
