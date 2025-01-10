local function nvim_version()
  local version = vim.version()
  local nvim_version_info = "  󰀨 v" .. version.major .. "." .. version.minor .. "." .. version.patch
  return nvim_version_info
end

return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 200,
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    quickfile = { enabled = true },
    rename = { enabled = true },
    words = { enabled = true },
    ---@type snacks.indent.Config
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
    -- @type snacks.dashboard.Config
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
          { icon = "󰍉", key = "f", desc = "Find File", action = "<cmd>Telescope find_files<cr>" },
          -- { icon = "", key = "n",  desc = "File Browser", action = "<cmd>Telescope <cr>" },
          { icon = "󰈢", key = "o", desc = "Recently Opened Files", action = "<cmd>Telescope oldfiles<cr>" },
          -- -- button("SPC f r", "  Frecency/MRU"),
          { icon = "󰈬", key = "g", desc = "Find Word", action = "<cmd>Telescope live_grep<cr>" },
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
    -- input = { enabled = true },
  },
  keys = {
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
  },
}
