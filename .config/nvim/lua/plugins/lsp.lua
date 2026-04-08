return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = { "mason.nvim", "fidget.nvim" },
    config = vim.schedule_wrap(function() require("config.lsp") end),
  },

  -- Flutter
  {
    "akinsho/flutter-tools.nvim",
    ft = "dart",
    opts = function()
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
          -- capabilities = config.capabilities, -- e.g. lsp_status capabilities
          -- handlers = config.handlers,
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
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    config = vim.schedule_wrap(function(_, opts)
      require("mason").setup(opts)
      -- auto start lsp server
      local installed_packs = require("mason-registry").get_installed_packages()
      local lsp_config_names = vim.iter(installed_packs):fold({}, function(acc, pack)
        table.insert(acc, pack.spec.neovim and pack.spec.neovim.lspconfig)
        return acc
      end)
      vim.lsp.enable(lsp_config_names)
    end),
    ---@class MasonSettings
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

  -- Lsp Status
  {
    "j-hui/fidget.nvim",
    opts = { notification = { window = { winblend = 0 } } },
  },

  {
    "SmiteshP/nvim-navic",
    init = function() vim.g.navic_silence = true end,
    opts = function()
      local no_navic_attach_lsp = { "graphql" }
      Snacks.util.lsp.on({ method = "textDocument/documentSymbol" }, function(buffer, client)
        if vim.tbl_contains(no_navic_attach_lsp, client.name) then return end
        require("nvim-navic").attach(client, buffer)
      end)

      local function get_icons()
        local icons = {}
        local success, mini_icons = pcall(require, "mini.icons")
        if not success then return icons end

        local kinds = {
          "File",
          "Module",
          "Namespace",
          "Package",
          "Class",
          "Method",
          "Property",
          "Field",
          "Constructor",
          "Enum",
          "Interface",
          "Function",
          "Variable",
          "Constant",
          "String",
          "Number",
          "Boolean",
          "Array",
          "Object",
          "Key",
          "Null",
          "EnumMember",
          "Struct",
          "Event",
          "Operator",
          "TypeParameter",
        }
        for _, kind in ipairs(kinds) do
          local icon, _, _ = mini_icons.get("lsp", kind)
          table.insert(icons, icon)
        end

        return icons
      end

      return {
        lazy_update_context = true,
        icons = get_icons(),
      }
    end,
  },

  {
    "SmiteshP/nvim-navbuddy",
    keys = { { "<leader>N", "<cmd>Navbuddy<cr>", desc = "NavBuddy" } },
    opts = {
      lsp = { auto_attach = true },
      window = { border = vim.g.border },
    },
  },

  -- {
  --   "oribarilan/lensline.nvim",
  --   -- tag = "1.0.0", -- or: branch = 'release/1.x' for latest non-breaking updates
  --   event = "LspAttach",
  --   config = true,
  -- },

  -- Json Schema
  "b0o/SchemaStore.nvim",

  -- Typescript
  { "dmmulroy/tsc.nvim", ft = { "typescript", "typescriptreact" }, config = true },
  { "dmmulroy/ts-error-translator.nvim", ft = { "typescript", "typescriptreact" }, config = true },

  -- Java
  { "mfussenegger/nvim-jdtls", ft = "java" },

  -- Go
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    build = ":GoInstallDeps",
    config = true,
  },
}
