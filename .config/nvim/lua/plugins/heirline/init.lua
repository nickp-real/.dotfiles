return {
  {
    "rebelot/heirline.nvim",
    event = "UiEnter",
    dependencies = "SmiteshP/nvim-navic",
    keys = {
      --      { "<Tab>", ":bn<cr>", desc = "Next Buffer" },
      --      { "<S-Tab>", ":bp<cr>", desc = "Prev Buffer" },
      --      {
      --        "tb",
      --        function()
      --          local tabline = require("heirline").tabline
      --          local buflist = tabline._buflist[1]
      --          buflist._picker_labels = {}
      --          buflist._show_picker = true
      --          vim.cmd.redrawtabline()
      --          local char = vim.fn.getcharstr()
      --          local bufnr = buflist._picker_labels[char]
      --          if bufnr then
      --            vim.api.nvim_win_set_buf(0, bufnr)
      --          end
      --          buflist._show_picker = false
      --          vim.cmd.redrawtabline()
      --        end,
      --        desc = "Pick Buffer",
      --      },
    },
    opts = function()
      local colors = require("onedarkpro.helpers").get_colors()
      local conditions = require("heirline.conditions")

      return {
        statusline = require("plugins.heirline.statusline"),
        winbar = require("plugins.heirline.winbar"),
        --  tabline = require("plugins.heirline.tabline"),
        opts = {
          colors = colors,
          disable_winbar_cb = function(args)
            return conditions.buffer_matches({
              buftype = { "nofile", "prompt", "help", "quickfix" },
              filetype = { "^git.*", "fugitive", "Trouble", "dashboard" },
            }, args.buf)
          end,
        },
      }
    end,
  },
}
