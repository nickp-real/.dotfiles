local M = {
  "akinsho/bufferline.nvim",
  dependencies = {
    { "roobert/bufferline-cycle-windowless.nvim", opts = { default_enabled = true } },
  },
  event = "VeryLazy",
}

function M.keys()
  function ChangeTab(motion)
    local last_buffer_id = vim.fn.bufnr()
    local last_buffer_name = vim.fn.expand("%")

    if motion == "next" then
      vim.cmd.BufferLineCycleWindowlessNext()
    elseif motion == "prev" then
      vim.cmd.BufferLineCycleWindowlessPrev()
    else
      error("Invalid motion: " .. motion)
      return
    end

    if last_buffer_name == "" then
      vim.cmd("Bdelete " .. last_buffer_id)
    end
  end

  return {
    { "<Tab>", "<cmd>lua ChangeTab('next')<cr>", desc = "Next Buffer" },
    { "<S-Tab>", "<cmd>lua ChangeTab('prev')<cr>", desc = "Prev Buffer" },
    { "<leader><Tab>", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer Next" },
    { "<leader><S-Tab>", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer Prev" },
  }
end

M.opts = {
  options = {
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    close_command = "Bdelete! %d",
    always_show_bufferline = false,
    indicator = {
      icon = "▌",
      style = "icon",
    },
    offsets = {
      {
        filetype = "Outline",
        text = "Symbols Outline",
        highlight = "Directory",
        text_align = "center",
      },
      {
        filetype = "neo-tree",
        text = "Neo Tree",
        highlight = "Directory",
        text_align = "center",
      },
    },
  },
  highlights = {
    indicator_selected = {
      fg = "#61afef",
    },
  },
}

return M
