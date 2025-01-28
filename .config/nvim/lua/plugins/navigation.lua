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
        char = { enabled = false },
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
