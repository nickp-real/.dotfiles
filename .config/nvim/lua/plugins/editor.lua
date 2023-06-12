return {
  -- Git Signs
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    opts = {
      signs = {
        add = { text = "▌" },
        change = { text = "▌" },
        delete = { text = "▌" },
        topdelete = { text = "▌" },
        changedelete = { text = "▌" },
        untracked = { text = "▌" },
      },
      numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
      preview_config = { border = "rounded" },
      current_line_blame = true,
    },
  },

  -- Git Manager
  {
    "TimUntersberger/neogit",
    keys = { { "<leader>gs", vim.cmd.Neogit, desc = "Neogit" } },
    opts = {
      kind = "split",
      disable_builtin_notifications = true,
      disable_commit_confirmation = true,
      signs = {
        -- { CLOSED, OPENED }
        section = { "", "" },
        item = { "", "" },
      },
      integrations = {
        diffview = true,
      },
    },
  },

  -- File Tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    cmd = "Neotree",
    keys = { { "<C-n>", "<cmd>Neotree reveal toggle<cr>", desc = "Neo-tree" } },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then
          require("neo-tree")
        end
      end
    end,
    opts = function()
      return {
        use_popups_for_input = false,
        filesystem = {
          hijack_netrw_behavior = "open_current",
          follow_current_file = true,
          use_libuv_file_watcher = true,
        },
        event_handlers = {
          {
            event = "file_opened",
            handler = function(file_path)
              --auto close
              require("neo-tree").close_all()
            end,
          },
        },
        default_component_configs = {
          icon = {
            folder_empty = "󰜌",
            folder_empty_open = "󰜌",
          },
          git_status = {
            symbols = {
              renamed = "󰁕",
              unstaged = "󰄱",
            },
          },
        },
        document_symbols = {
          kinds = {
            File = { icon = "󰈙", hl = "Tag" },
            Namespace = { icon = "󰌗", hl = "Include" },
            Package = { icon = "󰏖", hl = "Label" },
            Class = { icon = "󰌗", hl = "Include" },
            Property = { icon = "󰆧", hl = "@property" },
            Enum = { icon = "󰒻", hl = "@number" },
            Function = { icon = "󰊕", hl = "Function" },
            String = { icon = "󰀬", hl = "String" },
            Number = { icon = "󰎠", hl = "Number" },
            Array = { icon = "󰅪", hl = "Type" },
            Object = { icon = "󰅩", hl = "Type" },
            Key = { icon = "󰌋", hl = "" },
            Struct = { icon = "󰌗", hl = "Type" },
            Operator = { icon = "󰆕", hl = "Operator" },
            TypeParameter = { icon = "󰊄", hl = "Type" },
            StaticMethod = { icon = "󰠄 ", hl = "Function" },
          },
        },
        source_selector = {
          sources = {
            { source = "filesystem", display_name = " 󰉓 Files " },
            { source = "git_status", display_name = " 󰊢 Git " },
          },
        },
      }
    end,
  },

  -- Fold
  {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = "kevinhwang91/promise-async",
    keys = {
      { "zR", ":lua require('ufo').openAllFolds()<cr>", desc = "Open All Folds" },
      { "zM", ":lua require('ufo').closeAllFolds()<cr>", desc = "Close All Folds" },
    },
    opts = function()
      local ufo = require("ufo")
      local promise = require("promise")

      local handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = (" 󰁂 %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end

      local ftMap = {
        -- vim = 'indent',
        python = { "indent" },
        -- git = ''
      }

      local function customizeSelector(bufnr)
        local function handleFallbackException(err, providerName)
          if type(err) == "string" and err:match("UfoFallbackException") then
            return ufo.getFolds(providerName, bufnr)
          else
            return promise.reject(err)
          end
        end

        return ufo
          .getFolds("lsp", bufnr)
          :catch(function(err)
            return handleFallbackException(err, "treesitter")
          end)
          :catch(function(err)
            return handleFallbackException(err, "indent")
          end)
      end
      return {
        provider_selector = function(bufnr, filetype, buftype)
          return ftMap[filetype] or customizeSelector
        end,
        -- provider_selector = function(bufnr, filetype, buftype)
        --   return { "treesitter", "indent" }
        -- end,
        fold_virt_text_handler = handler,
      }
    end,
  },

  -- Session Manager
  {
    "Shatur/neovim-session-manager",
    cmd = "SessionManager",
    config = function(_, opts)
      require("session_manager").setup(opts)
    end,
    keys = {
      { "<leader>sl", "<cmd>SessionManager load_last_session<cr>", desc = "Load Last Session" },
      { "<leader>sn", "<cmd>SessionManager load_session<cr>", desc = "View All Session" },
    },
    opts = function()
      return {
        sessions_dir = require("plenary.path"):new(vim.fn.stdpath("data"), "sessions"), -- The directory where the session files will be saved.
        path_replacer = "__", -- The character to which the path separator will be replaced for session files.
        colon_replacer = "++", -- The character to which the colon symbol will be replaced for session files.
        autoload_mode = require("session_manager.config").AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
        autosave_last_session = true, -- Automatically save last session on exit and on session switch.
        autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
        autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
          "gitcommit",
        },
        autosave_only_in_session = true, -- Always autosaves session. If true, only autosaves after a session is active.
      }
    end,
  },

  -- Telescope, File browser
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-telescope/telescope-media-files.nvim",
    },
    cmd = "Telescope",
    keys = function()
      local find_files = function(opts)
        opts = opts or {} -- define here if you want to define something
        vim.fn.system("git rev-parse --is-inside-work-tree")
        if vim.v.shell_error == 0 then
          require("telescope.builtin").git_files(vim.tbl_deep_extend("force", { show_untracked = true }, opts))
        else
          require("telescope.builtin").find_files(opts)
        end
      end

      local find_lsp = function()
        require("telescope.builtin").lsp_document_symbols({
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        })
      end
      return {
        { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
        { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "Find in Files (Grep)" },
        { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        {
          "<leader><space>",
          function()
            require("telescope.builtin").find_files({ cwd = vim.loop.cwd() })
          end,
          desc = "Find Files (cwd)",
        },
        { "<leader>ff", find_files, desc = "Find Files" },
        {
          "<leader>fg",
          function()
            require("telescope.builtin").live_grep({ cwd = vim.loop.cwd() })
          end,
          desc = "Find in Files (Grep, CWD)",
        },
        { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
        { "<leader>fc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
        { "<leader>fs", "<cmd>Telescope git_status<CR>", desc = "status" },
        { "<leader>fa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
        { "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Commands" },
        { "<leader>fv", "<cmd>Telescope vim_options<cr>", desc = "Options" },
        { "<leader>fH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
        { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
        { "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
        { "<leader>fB", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
        { "<leader>fh", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<F1>", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
        { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
        { "<leader>fn", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
        {
          "<leader>fl",
          find_lsp,
          desc = "Goto Symbol",
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")
      telescope.load_extension("media_files")
    end,
    opts = {
      defaults = {
        pickers = {
          find_files = {
            find_command = { "fd", "--hidden", "--glob", "" },
          },
          buffers = {
            show_all_buffers = true,
            sort_mru = true,
            mapping = {
              i = {
                ["<c-d>"] = "delete_buffer",
              },
            },
          },
        },
        prompt_prefix = "   ",
        path_display = { "smart" },
        preview = {
          treesitter = true,
        },
        color_devicons = true,
        initial_mode = "normal",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.6,
            results_width = 0.4,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_ignore_patterns = { ".git/", "node_modules" },
        mappings = {
          i = {
            ["<C-u>"] = false,
          },
        },
      },
    },
  },

  -- Debug Adaptor Protocol
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        "mxsdev/nvim-dap-vscode-js",
        {
          "microsoft/vscode-js-debug",
          -- version = "1.x",
          build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
        },
      },
    },
    keys = {
      { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
      { "<leader>dc", '<cmd>lua require("dap").continue()<cr>', desc = "Continue" },
      { "<leader>do", '<cmd>lua require("dap").step_over()<cr>', desc = "Step Over" },
      { "<leader>di", '<cmd>lua require("dap").step_into()<cr>', desc = "Step Into" },
      { "<leader>de", '<cmd>lua require("dap").step_out()<cr>', desc = "Step Out" },
      { "<leader>dw", '<cmd>lua require("dap.ui.widgets").hover()<cr>', desc = "Widgets" },
      { "<leader>dr", '<cmd>lua require("dap").repl.open()<cr>', desc = "Repl" },
      { "<leader>du", '<cmd>lua require("dapui").toggle({})<cr>', desc = "Dap UI" },
    },
    config = function()
      local dap = require("dap")

      require("dap-vscode-js").setup({
        debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
      })

      local js_debug = { "typescript", "typescriptreact", "javascript", "javascriptreact", "svelte" }
      for _, language in ipairs(js_debug) do
        dap.configurations[language] = {
          -- attach to a node process that has been started with
          -- `--inspect` for longrunning tasks or `--inspect-brk` for short tasks
          -- npm script -> `node --inspect-brk ./node_modules/.bin/vite dev`
          {
            -- use nvim-dap-vscode-js's pwa-node debug adapter
            type = "pwa-node",
            -- attach to an already running node process with --inspect flag
            -- default port: 9222
            request = "attach",
            -- allows us to pick the process using a picker
            processId = require("dap.utils").pick_process,
            -- name of the debug action you have to select for this config
            name = "Attach debugger to existing `node --inspect` process",
            -- for compiled languages like TypeScript or Svelte.js
            sourceMaps = true,
            -- resolve source maps in nested locations while ignoring node_modules
            resolveSourceMapLocations = {
              "${workspaceFolder}/**",
              "!**/node_modules/**",
            },
            -- path to src in vite based projects (and most other projects as well)
            cwd = "${workspaceFolder}/src",
            -- we don't want to debug code inside node_modules, so skip it!
            skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
          },
          {
            type = "pwa-chrome",
            name = "Launch Chrome to debug client",
            request = "launch",
            url = "http://localhost:5173",
            sourceMaps = true,
            protocol = "inspector",
            port = 9222,
            webRoot = "${workspaceFolder}/src",
            -- skip files from vite's hmr
            skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
          },
          -- only if language is javascript, offer this debug action
          language == "javascript"
              and {
                -- use nvim-dap-vscode-js's pwa-node debug adapter
                type = "pwa-node",
                -- launch a new process to attach the debugger to
                request = "launch",
                -- name of the debug action you have to select for this config
                name = "Launch file in new node process",
                -- launch current file
                program = "${file}",
                cwd = "${workspaceFolder}",
              }
            or nil,
        }

        local dapui = require("dapui")
        dapui.setup()

        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({ reset = true })
        end
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close
      end
    end,
  },

  -- Diff view
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview" },
      { "<leader>gF", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview File History (cwd)" },
      { "<leader>gf", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview File History (root dir)" },
    },
    init = function()
      vim.api.nvim_create_user_command("DiffviewToggle", function(e)
        local view = require("diffview.lib").get_current_view()

        if view then
          vim.cmd("DiffviewClose")
        else
          vim.cmd("DiffviewOpen " .. e.args)
        end
      end, { nargs = "*" })
    end,
    opts = {
      view = {
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
    },
  },

  -- Desc generator
  {
    "danymat/neogen",
    cmd = "Neogen",
    keys = { { "<leader>n", "<cmd>Neogen<cr>", desc = "Neogen" } },
    opts = { snippet_engine = "luasnip" },
  },

  -- Undo Tree
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undotree" } },
  },

  {
    "chentoast/marks.nvim",
    event = "BufReadPost",
    opts = {
      default_mappings = true,
      signs = true,
      mappings = {},
    },
  },
}
