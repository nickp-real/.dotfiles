return {
  -- Git Signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    opts = {
      signs = {
        add = { text = "▌" },
        change = { text = "▌" },
        delete = { text = "▌" },
        topdelete = { text = "▌" },
        changedelete = { text = "▌" },
        untracked = { text = "▌" },
      },
      preview_config = { border = vim.g.border },
      current_line_blame = true,
    },
  },

  -- Git Manager
  {
    "NeogitOrg/neogit",
    keys = { { "<leader>gs", vim.cmd.Neogit, desc = "Neogit" } },
    opts = {
      kind = "split",
      disable_commit_confirmation = true,
      signs = {
        -- { CLOSED, OPENED }
        section = { "", "" },
        item = { "", "" },
      },
      integrations = {
        telescope = true,
        diffview = true,
      },
    },
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
}
