return {
  -- Fold
  {
    "chrisgrieser/nvim-origami",
    event = "VeryLazy",
    init = function()
      vim.opt.foldlevel = 99
      vim.opt.foldlevelstart = 99
    end,
    ---@module 'origami'
    ---@type Origami.config
    opts = {
      foldtext = {
        lineCount = {
          template = "    󰘕 %d",
        },
      },
    }, -- needed even when using default config
  },

  -- Undo Tree
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" } },
  },

  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    opts = {
      default_mappings = true,
      signs = true,
      mappings = {},
    },
  },

  -- trouble finder
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    init = function()
      -- vim.api.nvim_create_autocmd("QuickFixCmdPost", {
      --   callback = function() vim.cmd([[Trouble qflist open]]) end,
      -- })

      vim.api.nvim_create_autocmd("BufRead", {
        callback = function(ev)
          if vim.bo[ev.buf].buftype == "quickfix" then
            vim.schedule(function()
              vim.cmd([[cclose]])
              vim.cmd([[Trouble qflist open]])
            end)
          end
        end,
      })
    end,
    opts = {
      use_diagnostic_signs = true,
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      {
        "<leader>cS",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP references/definitions/... (Trouble)",
      },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").prev({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then require("snacks").notify.error(err) end
          end
        end,
        desc = "Previous Trouble/Quickfix Item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then require("snacks").notify.error(err) end
          end
        end,
        desc = "Next Trouble/Quickfix Item",
      },
    },
  },

  -- TODO comments
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    config = true,
    keys = {
      {
        "]t",
        function() require("todo-comments").jump_next() end,
        desc = "Next todo comment",
      },
      {
        "[t",
        function() require("todo-comments").jump_prev() end,
        desc = "Previous todo comment",
      },
      { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo Trouble" },
      { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo Trouble" },
    },
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    opts = {
      preset = "simple",
      options = {
        show_source = {
          enabled = true,
          if_many = false,
        },
        multilines = true,
        use_icons_from_diagnostic = true,
        show_all_diags_on_cursorline = true,
      },
      signs = {
        diag = "",
      },
    },
  },

  -- Search & Replace
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },
}
