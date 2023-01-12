local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-media-files.nvim",
  },
  cmd = "Telescope",
}

M.keys = {
  { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
  { "<leader>/", require("utils").telescope("live_grep"), desc = "Find in Files (Grep)" },
  { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
  { "<leader><space>", require("utils").telescope("files"), desc = "Find Files (root dir)" },
  { "<leader>fF", require("utils").telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
  { "<leader>ff", require("utils").telescope("files"), desc = "Find Files (root dir)" },
  { "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
  { "<leader>fc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
  { "<leader>fs", "<cmd>Telescope git_status<CR>", desc = "status" },
  { "<leader>fa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
  { "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Commands" },
  { "<leader>fv", "<cmd>Telescope vim_options<cr>", desc = "Options" },
  { "<leader>ft", "<cmd>Telescope builtin<cr>", desc = "Telescope" },
  { "<leader>fH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
  { "<leader>fG", require("utils").telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
  { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
  { "<leader>fM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
  { "<leader>fB", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
  { "<leader>fh", "<cmd>Telescope command_history<cr>", desc = "Command History" },
  { "<leader>fg", require("utils").telescope("live_grep"), desc = "Grep (root dir)" },
  { "<leader>fV", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
  { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
  { "<leader>fn", "<cmd>Telescope file_browser<cr>", desc = "File Browser" },
  {
    "<leader>fl",
    require("utils").telescope("lsp_document_symbols", {
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
    }),
    desc = "Goto Symbol",
  },
}

function M.config(_, opts)
  local telescope = require("telescope")
  telescope.setup(opts)
  telescope.load_extension("fzf")
  telescope.load_extension("file_browser")
  telescope.load_extension("media_files")
end

M.opts = {
  defaults = {
    pickers = {
      find_files = {
        find_command = { "fd", "--hidden", "--glob", "" },
      },
    },
    prompt_prefix = "   ",
    path_display = { "smart" },
    preview = {
      treesitter = true,
    },
    color_devicons = true,
    initial_mode = "insert",
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
}

return M
