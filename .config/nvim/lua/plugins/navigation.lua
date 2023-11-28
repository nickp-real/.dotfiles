return {
  -- File Tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = { { "<C-n>", "<cmd>Neotree toggle<cr>", desc = "Neo Tree" } },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
      if vim.fn.argc() == 1 then
        local stat = vim.loop.fs_stat(vim.fn.argv(0))
        if stat and stat.type == "directory" then require("neo-tree") end
      end
    end,
    deactivate = function() vim.cmd.Neotree("close") end,
    opts = function()
      return {
        open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy", "Outline" },
        use_popups_for_input = false,
        filesystem = {
          hijack_netrw_behavior = "open_current",
          bind_to_cwd = false,
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
        event_handlers = {
          {
            event = "file_opened",
            handler = function(file_path)
              --auto close
              vim.cmd.Neotree("close")
            end,
          },
          {
            event = "neo_tree_window_after_open",
            handler = function(args)
              if args.position == "left" or args.position == "right" then vim.cmd.wincmd("=") end
            end,
          },
          {
            event = "neo_tree_window_after_close",
            handler = function(args)
              if args.position == "left" or args.position == "right" then vim.cmd.wincmd("=") end
            end,
          },
        },
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
          function() require("telescope.builtin").find_files({ cwd = vim.loop.cwd() }) end,
          desc = "Find Files (cwd)",
        },
        { "<leader>ff", find_files, desc = "Find Files" },
        {
          "<leader>fg",
          function() require("telescope.builtin").live_grep({ cwd = vim.loop.cwd() }) end,
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
        { "<leader>fB", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "FzF Current Buffer" },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
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
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "" then return win end
          end
          return 0
        end,
        mappings = {
          i = {
            ["<C-u>"] = false,
          },
        },
      },
    },
  },

  -- Jump in buffer
  {
    "folke/flash.nvim",
    keys = {
      { "f", "F", "t", "T", ";", "," },
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
    opts = { jump = { nohlsearch = true } },
  },

  -- pane
  {
    "mrjones2014/smart-splits.nvim",
    keys = {
      -- resize
      { "<A-h>", function() require("smart-splits").resize_left() end, desc = "Resize Left" },
      { "<A-j>", function() require("smart-splits").resize_down() end, desc = "Resize Down" },
      { "<A-k>", function() require("smart-splits").resize_up() end, desc = "Resize Up" },
      { "<A-l>", function() require("smart-splits").resize_right() end, desc = "Resize Right" },
      -- move
      { "<C-h>", function() require("smart-splits").move_cursor_left() end, desc = "Move To Left Pane" },
      { "<C-j>", function() require("smart-splits").move_cursor_down() end, desc = "Move To Down Pane" },
      { "<C-k>", function() require("smart-splits").move_cursor_up() end, desc = "Move To Up Pane" },
      { "<C-l>", function() require("smart-splits").move_cursor_right() end, desc = "Move To Right Pane" },
      -- swap
      { "<leader><C-h>", function() require("smart-splits").swap_buf_left() end, desc = "Swap Left Pane" },
      { "<leader><C-j>", function() require("smart-splits").swap_buf_down() end, desc = "Swap Down Pane" },
      { "<leader><C-k>", function() require("smart-splits").swap_buf_up() end, desc = "Swap Left Pane" },
      { "<leader><C-l>", function() require("smart-splits").swap_buf_right() end, desc = "Swap Left Pane" },
    },
    opts = { default_amount = 5 },
  },
}
