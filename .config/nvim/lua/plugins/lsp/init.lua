return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "fidget.nvim",
      { "lvimuser/lsp-inlayhints.nvim", config = true },
      {
        "SmiteshP/nvim-navbuddy",
        keys = { { "<leader>n", "<cmd>Navbuddy<cr>", desc = "NavBuddy" } },
        opts = { lsp = { auto_attach = true } },
      },
    },
    config = function()
      require("lspconfig.ui.windows").default_options.border = vim.g.border
      require("plugins.lsp.config").setup()
    end,
  },

  -- conform
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      {
        "=",
        function()
          local extra_lang_args = { svelte = { lsp_fallback = "always" } }
          require("conform").format(
            vim.tbl_deep_extend(
              "force",
              { async = true, lsp_fallback = true, timeout_ms = 500 },
              extra_lang_args[vim.bo.ft] or {}
            ),
            function(err)
              if not err then
                if vim.startswith(vim.api.nvim_get_mode().mode:lower(), "v") then
                  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "n", true)
                end
              end
            end
          )
        end,
        mode = "",
        desc = "Format Buffer",
      },
      {
        "<leader>f",
        function()
          local extra_lang_args = { svelte = { lsp_fallback = "always" } }
          require("conform").format(
            vim.tbl_deep_extend("force", { lsp_fallback = true, timeout_ms = 500 }, extra_lang_args[vim.bo.ft] or {})
          )
        end,
        desc = "[F]ormat",
      },
      {
        "<leader>fe",
        require("plugins.lsp.config").toggle_auto_format,
        expr = true,
        desc = "[F]ormat [E]nable/Disable",
      },
    },
    init = function() vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" end,
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettierd" },
        typescript = { "prettierd" },
        javascriptreact = { "prettierd" },
        typescriptreact = { "prettierd" },
        vue = { "prettierd" },
        astro = { "prettierd" },
        -- svelte = { },
        markdown = { "prettierd" },
        go = { "gofumpt", "goimports-reviser", "golines" },
        bash = { "shfmt" },
        json = { "jq" },
        -- Use the "*" filetype to run formatters on all filetypes.
        -- ["*"] = { "codespell" },
        -- Use the "_" filetype to run formatters on filetypes that don't
        -- have other formatters configured.
        ["_"] = { "trim_whitespace", "trim_newlines" },
      },
      -- If this is set, Conform will run the formatter on save.
      -- It will pass the table to conform.format().
      -- This can also be a function that returns the table.
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
        local extra_lang_args = { svelte = { lsp_fallback = "always" } }
        return vim.tbl_deep_extend("force", { lsp_fallback = true, timeout_ms = 500 }, extra_lang_args[vim.bo.ft] or {})
      end,
      formatters = {
        jq = { prepend_args = { "--sort-keys" } },
      },
    },
  },

  -- Flutter
  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    opts = function()
      local config = require("plugins.lsp.config")
      return {
        ui = {
          -- the border type to use for all floating windows, the same options/formats
          -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
          border = vim.g.border,
          notification_style = "native",
        },
        decorations = {
          statusline = {
            -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
            -- this will show the current version of the flutter app from the pubspec.yaml file
            app_version = false,
            -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
            -- this will show the currently running device if an application was started with a specific
            -- device
            device = false,
          },
        },
        debugger = { -- integrate with nvim dap + install dart code debugger
          enabled = true,
          run_via_dap = false, -- use dap instead of a plenary job to run flutter apps
          exception_breakpoints = {},
          register_configurations = function(_)
            require("dap").configurations.dart = {}
            require("dap.ext.vscode").load_launchjs()
          end,
          -- register_configurations = function(paths)
          --   require("dap").configurations.dart = {
          --     -- <put here config that you would find in .vscode/launch.json>
          --   }
        },
        -- flutter_path = "<full/path/if/needed>", -- <-- this takes priority over the lookup
        -- flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
        -- fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
        widget_guides = {
          enabled = true,
        },
        closing_tags = {
          -- highlight = "ErrorMsg", -- highlight for the closing tag
          -- prefix = "// ", -- character to use for close tag e.g. > Widget
          enabled = true, -- set to false to disable
        },
        dev_log = {
          enabled = true,
          open_cmd = "tabedit", -- command to use to open the log buffer
        },
        dev_tools = {
          autostart = true, -- autostart devtools server if not detected
          auto_open_browser = false, -- Automatically opens devtools in the browser
        },
        outline = {
          open_cmd = "36vnew", -- command to use to open the outline buffer
          auto_open = false, -- if true this will open the outline automatically when it is first populated
        },
        lsp = {
          color = { -- show the derived colours for dart variables
            enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
            background = false, -- highlight the background
            background_color = { r = 19, g = 17, b = 24 },
            foreground = false, -- highlight the foreground
            virtual_text = true, -- show the highlight using virtual text
            virtual_text_str = "■", -- the virtual text character to highlight
          },
          -- on_attach = config.on_attach,
          capabilities = config.capabilities, -- e.g. lsp_status capabilities
          handlers = config.handlers,
          --- OR you can specify a function to deactivate or change or control how the config is created
          -- capabilities = function(config)
          --   config.specificThingIDontWant = false
          --   return config
          -- end,
          settings = {
            showTodos = false,
            completeFunctionCalls = true,
          },
        },
      }
    end,
  },

  -- Mason
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    opts = {
      ui = {
        border = vim.g.border,
        icons = {
          package_installed = "",
          package_pending = "",
          package_uninstalled = "",
        },
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = { "mason.nvim", "nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers(require("plugins.lsp.servers"))
    end,
  },

  -- Lsp Status
  {
    "j-hui/fidget.nvim",
    opts = { notification = { window = { winblend = 0 } } },
  },

  -- Json Schema
  "b0o/SchemaStore.nvim",

  -- Typescript
  -- { "NickP-real/typescript-tools.nvim", config = true, dev = true },
  { "pmizio/typescript-tools.nvim", config = true },
  { "dmmulroy/tsc.nvim", config = true },

  -- Java
  { "mfussenegger/nvim-jdtls", ft = "java" },

  -- Go
  { "olexsmir/gopher.nvim", ft = "go", build = ":GoInstallDeps", config = true },
}
