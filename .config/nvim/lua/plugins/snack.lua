local function nvim_version()
  local version = vim.version()
  local nvim_version_info = "  󰀨 v" .. version.major .. "." .. version.minor .. "." .. version.patch
  return nvim_version_info
end

return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1200,
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    quickfile = { enabled = true },
    rename = { enabled = true },
    words = { enabled = true },
    indent = {
      indent = {
        char = "▎",
      },
      scope = {
        char = "▎",
        underline = true,
        hl = vim.g.indent_highlights,
      },
      filter = function(buf)
        local disabled_ft = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        }

        for _, ft in ipairs(disabled_ft) do
          if vim.bo[buf].ft == ft then return false end
        end

        return vim.g.snack_indent ~= false and vim.b[buf].snack_indent ~= false and vim.bo[buf].buftype == ""
      end,
    },
    scope = { enabled = true },
    input = { enabled = true },
    dashboard = {
      preset = {
        header = [[
      ___           ___           ___           ___                       ___
     /\__\         /\  \         /\  \         /\__\          ___        /\__\
    /::|  |       /::\  \       /::\  \       /:/  /         /\  \      /::|  |
   /:|:|  |      /:/\:\  \     /:/\:\  \     /:/  /          \:\  \    /:|:|  |
  /:/|:|  |__   /::\~\:\  \   /:/  \:\  \   /:/__/  ___      /::\__\  /:/|:|__|__
 /:/ |:| /\__\ /:/\:\ \:\__\ /:/__/ \:\__\  |:|  | /\__\  __/:/\/__/ /:/ |::::\__\
 \/__|:|/:/  / \:\~\:\ \/__/ \:\  \ /:/  /  |:|  |/:/  / /\/:/  /    \/__/~~/:/  /
     |:/:/  /   \:\ \:\__\    \:\  /:/  /   |:|__/:/  /  \::/__/           /:/  /
     |::/  /     \:\ \/__/     \:\/:/  /     \::::/__/    \:\__\          /:/  /
     /:/  /       \:\__\        \::/  /       ~~~~         \/__/         /:/  /
     \/__/         \/__/         \/__/                                   \/__/    ]],
        keys = {
          { icon = "", key = "e", desc = "New File", action = "<cmd>ene<bar>startinsert<cr>" },
          {
            icon = "󰍉",
            key = "f",
            desc = "Find File",
            action = function() require("snacks").picker.files({ hidden = true }) end,
          },
          -- { icon = "", key = "n",  desc = "File Browser", action = "<cmd>Telescope <cr>" },
          {
            icon = "󰈢",
            key = "o",
            desc = "Recently Opened Files",
            action = function() require("snacks").picker.recent() end,
          },
          -- -- button("SPC f r", "  Frecency/MRU"),
          {
            icon = "󰈬",
            key = "g",
            desc = "Find Word",
            action = function() require("snacks").picker.grep() end,
          },
          -- { icon = "", key = "SPC f m", desc = "Jump to Bookmarks", action = "" },
          -- { icon = "󰁯", key = "SPC s l", desc = "Open Last Session", action = "" },
          { icon = "", key = "v", desc = "Neovim Config", action = "<cmd>e ~/.config/nvim/init.lua<cr>" },
          -- -- button("p", "  Plugin Config", "<cmd>e ~/.config/nvim/after/plugin/<CR>"),
          -- -- button("t", "󰃣  Theme Config", "<cmd>e ~/.config/nvim/plugin/theme.lua<CR>"),
          { icon = "", key = "q", desc = "Quit", action = "<cmd>qa<CR>" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },
        { align = "center", text = { nvim_version(), hl = "footer" } },
      },
    },
    picker = {
      on_show = function() vim.cmd.stopinsert() end,
      win = {
        preview = {
          wo = {
            winbar = "",
          },
        },
      },
    },
    notifier = {
      top_down = false,
      timeout = 5000,
    },
    -- scroll = {
    --   enabled = true,
    --   filter = function(buf)
    --     return vim.bo[buf].ft == "snacks_picker_preview"
    --   end,
    -- },
    styles = {
      input = {
        relative = "cursor",
        row = -3,
        border = vim.g.border,
        on_win = function() vim.schedule(vim.cmd.stopinsert) end,
      },
    },
  },
  keys = {
    -- words
    {
      "]]",
      function() require("snacks").words.jump(vim.v.count1) end,
      desc = "Next Reference",
      mode = { "n", "t" },
    },
    {
      "[[",
      function() require("snacks").words.jump(-vim.v.count1) end,
      desc = "Prev Reference",
      mode = { "n", "t" },
    },
    -- picker
    { "<leader>fh", function() require("snacks").picker.help() end, desc = "[F]ind [H]elp" },
    { "<leader>fk", function() require("snacks").picker.keymaps() end, desc = "[F]ind [K]eymaps" },
    {
      "<leader>ff",
      function() require("snacks").picker.files({ hidden = true }) end,
      desc = "[F]ind [F]iles",
    },
    { "<leader>fs", function() require("snacks").picker.pickers() end, desc = "[F]ind [S]elect Picker" },
    { "<leader>fw", function() require("snacks").picker.grep_word() end, desc = "[F]ind current [W]ord" },
    { "<leader>fg", function() require("snacks").picker.grep() end, desc = "[F]ind by [G]rep" },
    { "<leader>fd", function() require("snacks").picker.diagnostics() end, desc = "[F]ind [D]iagnostics" },
    { "<leader>fr", function() require("snacks").picker.resume() end, desc = "[F]ind [R]esume" },
    {
      "<leader>f.",
      function() require("snacks").picker.recent() end,
      desc = "[F]ind Recent Files ('.' for repeat)",
    },
    {
      "<leader><leader>",
      function() require("snacks").picker.buffers({ current = false, focus = "list" }) end,
      desc = "[ ] Find existing buffers",
    },
    {
      "<leader>/",
      function() require("snacks").picker.grep_buffers({ layout = { preset = "ivy", preview = "main" } }) end,
      desc = "[/] Fuzzily searchin current buffer",
    },
    {
      "<leader>fl",
      function() require("snacks").picker.lines({ layout = { preview = false } }) end,
      desc = "[F]inding [L]ine",
    },
    {
      "<leader>fn",
      function()
        require("snacks").picker.files({
          cwd = vim.fn.stdpath("config") --[[@as string]],
        })
      end,
      desc = "[F]ind [N]eovim files",
    },
    { "<leader>ft", function() require("snacks").picker.pick("todo_comments") end },
    { "<leader>n", function() require("snacks").picker.notifications() end },
    -- notification
    { "<leader>nd", function() require("snacks").notifier.hide() end, desc = "Dismiss All Notifications" },
  },
}
