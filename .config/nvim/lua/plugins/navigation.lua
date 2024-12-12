return {
  -- File Tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = { { "<C-n>", "<cmd>Neotree position=right toggle=true<cr>", desc = "Neo Tree" } },
    init = function()
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0) --[[@as string]])
            if stats and stats.type == "directory" then require("neo-tree") end
          end
        end,
      })
      -- if vim.fn.argc(-1) == 1 then
      --   local stat = vim.uv.fs_stat(vim.fn.argv(0))
      --   if stat and stat.type == "directory" then require("neo-tree") end
      -- end
    end,
    deactivate = function() vim.cmd.Neotree("close") end,
    opts = function()
      local on_move = function(data) require("snacks").rename.on_rename_file(data.source, data.destination) end
      local resize = function(data)
        if data.position == "left" or data.position == "right" then vim.cmd.wincmd("=") end
      end

      local events = require("neo-tree.events")
      return {
        open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "edgy", "Outline" },
        use_popups_for_input = false,
        filesystem = {
          hijack_netrw_behavior = "open_current",
          bind_to_cwd = false,
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        -- window = { auto_expand_width = true },
        event_handlers = {
          { event = events.FILE_OPENED, handler = function(file_path) vim.cmd.Neotree("close") end },
          { event = events.NEO_TREE_WINDOW_AFTER_OPEN, handler = resize },
          { event = events.NEO_TREE_WINDOW_AFTER_CLOSE, handler = resize },
          { event = events.FILE_MOVED, handler = on_move },
          { event = events.FILE_RENAMED, handler = on_move },
        },
      }
    end,
  },

  -- Telescope, File browser
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope",
    keys = function()
      local builtin = require("telescope.builtin")
      return {
        { "<leader>fh", builtin.help_tags, desc = "[F]ind [H]elp" },
        { "<leader>fk", builtin.keymaps, desc = "[F]ind [K]eymaps" },
        { "<leader>ff", function() builtin.find_files({ hidden = true }) end, desc = "[F]ind [F]iles" },
        { "<leader>fs", builtin.builtin, desc = "[F]ind [S]elect Telescope" },
        { "<leader>fw", builtin.grep_string, desc = "[F]ind current [W]ord" },
        { "<leader>fg", builtin.live_grep, desc = "[F]ind by [G]rep" },
        { "<leader>fd", builtin.diagnostics, desc = "[F]ind [D]iagnostics" },
        { "<leader>fr", builtin.resume, desc = "[F]ind [R]esume" },
        { "<leader>f.", builtin.oldfiles, desc = "[F]ind Recent Files ('.' for repeat)" },
        { "<leader><leader>", builtin.buffers, desc = "[ ] Find existing buffers" },
        {
          "<leader>/",
          function()
            builtin.current_buffer_fuzzy_find({
              previewer = false,
              layout_config = {
                width = 0.87,
                height = 0.80,
              },
            })
          end,
          desc = "[/] Fuzzily searchin current buffer",
        },
        {
          "<leader>f/",
          function() builtin.live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" }) end,
          desc = "[F]ind [/] in Open Files",
        },
        { "<leader>fn", function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end },
        desc = "[F]ind [N]eovim files",
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("fzf")
    end,
    opts = function()
      return {
        defaults = {
          prompt_prefix = "   ",
          path_display = { "smart" },
          preview = { treesitter = true },
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
            vertical = { mirror = false },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          file_ignore_patterns = { ".git/" },
          get_selection_window = function()
            local wins = vim.api.nvim_list_wins()
            table.insert(wins, 1, vim.api.nvim_get_current_win())
            for _, win in ipairs(wins) do
              local buf = vim.api.nvim_win_get_buf(win)
              if vim.bo[buf].buftype == "" then return win end
            end
            return 0
          end,
          mappings = { i = { ["<C-u>"] = false } },
        },
        pickers = {
          find_files = { find_command = { "rg", "--files", "--color", "never", "-g", "!.git" } },
          buffers = {
            show_all_buffers = true,
            sort_mru = true,
            ignore_current_buffer = true,
            sort_lastused = true,
            mappings = { n = { d = "delete_buffer", q = "close" } },
            previewer = false,
          },
        },
        extensions = { fzf = {} },
      }
    end,
  },

  -- Jump in buffer
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      -- { "f", "F", "t", "T", ";", "," },
      { "<cr>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
    opts = {
      jump = { nohlsearch = true },
      modes = {
        char = { autohide = true },
        search = { enabled = true },
      },
    },
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
