return {
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "mason.nvim",
      "fidget.nvim",
      "mason-lspconfig.nvim",
      { "lvimuser/lsp-inlayhints.nvim", config = true },
    },
    config = function()
      require("lsp.config").setup()
      local lspconfig = require("lspconfig")

      local utils = require("lsp.utils")
      local root_pattern = require("lspconfig.util").root_pattern
      utils.lsp_mapping()

      local lsp_default = {
        capabilities = utils.capabilities,
        flags = utils.flags,
      }
      lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_default)

      local no_format_servers = { "gopls", "emmet_ls" }
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          if no_format_servers[server_name] then
            lspconfig[server_name].setup({
              on_attach = utils.no_format_on_attach,
            })
          else
            lspconfig[server_name].setup({
              on_attach = utils.on_attach,
            })
          end
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            on_attach = require("lsp.servers.lua_ls").on_attach,
            settings = require("lsp.servers.lua_ls").settings,
          })
        end,
        ["pyright"] = function()
          lspconfig.pyright.setup({
            on_attach = utils.no_format_on_attach,
            settings = require("lsp.servers.pyright").settings,
          })
        end,
        ["jsonls"] = function()
          lspconfig.jsonls.setup({
            on_attach = utils.no_format_on_attach,
            settings = require("lsp.servers.jsonls").settings,
          })
        end,
        ["tsserver"] = function()
          require("typescript").setup({
            disable_commands = false, -- prevent the plugin from creating Vim commands
            debug = false, -- enable debug logging for commands
            -- LSP Config options
            server = {
              capabilities = require("lsp.servers.tsserver").capabilities,
              on_attach = require("lsp.servers.tsserver").on_attach,
              settings = require("lsp.servers.tsserver").settings,
              flags = utils.flags,
              handlers = require("lsp.servers.tsserver").handlers,
              single_file_support = true,
            },
          })
          require("tsc")
        end,
        ["svelte"] = function()
          lspconfig.svelte.setup({
            on_attach = require("lsp.servers.svelte").on_attach,
            settings = require("lsp.servers.svelte").settings,
          })
        end,
        ["eslint"] = function()
          lspconfig.eslint.setup({
            on_attach = require("lsp.servers.eslint").on_attach,
            settings = require("lsp.servers.eslint").settings,
          })
        end,
        ["tailwindcss"] = function()
          lspconfig.tailwindcss.setup({
            capabilities = require("lsp.servers.tailwindcss").capabilities,
            filetypes = require("lsp.servers.tailwindcss").filetypes,
            on_attach = utils.no_format_on_attach,
            init_options = require("lsp.servers.tailwindcss").init_options,
            settings = require("lsp.servers.tailwindcss").settings,
            root_dir = root_pattern(unpack(require("lsp.servers.tailwindcss").root_dir)),
          })
          require("tailwind-sorter")
        end,
        ["html"] = function()
          lspconfig.html.setup({
            on_attach = utils.on_attach,
            filetypes = require("lsp.servers.html").filetypes,
            settings = require("lsp.servers.html").settings,
          })
        end,
        ["cssls"] = function()
          lspconfig.cssls.setup({
            on_attach = utils.no_format_on_attach,
            settings = require("lsp.servers.cssls").settings,
          })
        end,
      })
    end,
  },

  -- null-ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "mason.nvim", "mason-lspconfig.nvim" },
    event = "BufReadPre",
    opts = function()
      local null_ls = require("null-ls")

      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics
      local code_actions = null_ls.builtins.code_actions

      local sources = {
        ----------------
        -- Formatting --
        ----------------

        -- lua
        formatting.stylua,

        -- python
        formatting.black.with({ extra_args = { "--fast" } }),

        -- front-end
        formatting.prettierd.with({
          extra_filetypes = { "svelte", "toml" },
          -- condition = function(utils)
          --   return utils.has_file({
          --     ".prettierrc.js",
          --     ".prettierrc.cjs",
          --     "prettier.config.js",
          --     "prettier.config.cjs",
          --     ".prettierrc",
          --     ".prettierrc.json",
          --     ".prettierrc.yml",
          --     ".prettierrc.yaml",
          --     ".prettierrc.json5",
          --   })
          -- end,
        }),
        -- formatting.prettierd.with({ extra_filetypes = { "svelte", "toml" }, condition = function (utils)
        --   return utils.has_file({".prettierrc.js"})
        -- end }),

        -- go
        formatting.golines,

        ----------------
        -- Diagnostic --
        ----------------

        -- front-end
        -- diagnostics.eslint_d.with({
        --   condition = function(utils)
        --     return utils.root_has_file({ ".eslintrc.json" })
        --   end,
        -- }),

        ------------------
        -- Code Actions --
        ------------------

        -- front-end
        -- code_actions.eslint_d.with({
        --   condition = function(utils)
        --     return utils.root_has_file({ ".eslintrc.json" })
        --   end,
        -- }),
        require("typescript.extensions.null-ls.code-actions"),
      }

      local utils = require("lsp.utils")

      return {
        sources = sources,
        on_attach = function(client, bufnr)
          if client.server_capabilities.documentFormattingProvider then
            utils.auto_format(client, bufnr)
          end
        end,
        update_in_insert = false,
        debounce = 150,
      }
    end,
  },

  -- Flutter
  {
    "akinsho/flutter-tools.nvim",
    ft = { "dart" },
    opts = function()
      local utils = require("lsp.utils")
      return {
        ui = {
          -- the border type to use for all floating windows, the same options/formats
          -- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
          border = "rounded",
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
          -- end,
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
          on_attach = utils.on_attach,
          capabilities = utils.capabilities, -- e.g. lsp_status capabilities
          handlers = utils.handlers,
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
    cmd = "Mason",
    opts = {
      ui = {
        -- border = "rounded",
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
    opts = {
      ensure_installed = {
        "bashls",
        "cssls",
        "html",
        "jsonls",
        "lua_ls",
        "tailwindcss",
        "tsserver",
        "clangd",
        "gopls",
        "pyright",
      },
      automatic_installation = true,
    },
  },

  -- lsp status
  {
    "j-hui/fidget.nvim",
    opts = {
      window = {
        blend = 0,
      },
    },
  },

  -- lsp trouble finder
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle<cr>", desc = "Trouble Toggle" },
      { "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble Workspace" },
      { "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble Document" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble Quickfix" },
      { "<leader>xl", "<cmd>TroubleToggle loclist<cr>", desc = "Trouble Loclist" },
      { "<leader>xr", "<cmd>TroubleToggle lsp_references<cr>", desc = "Trouble LSP" },
    },
  },

  -- Json Schema
  "b0o/SchemaStore.nvim",

  -- Typescript
  "jose-elias-alvarez/typescript.nvim",
  { "dmmulroy/tsc.nvim", config = true },

  -- Java
  { "mfussenegger/nvim-jdtls", ft = "java" },

  -- Tailwind CSS
  {
    "laytan/tailwind-sorter.nvim",
    build = "cd formatter && npm i && npm run build",
    opts = { on_save_enabled = true },
  },

  -- Utils
  "KostkaBrukowa/definition-or-references.nvim",
}
