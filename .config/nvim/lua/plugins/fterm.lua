local M = {
  "numToStr/FTerm.nvim",
}

M.keys = {
  { "<C-_>", "<cmd>lua require('FTerm').toggle()<cr>", desc = "Open Float Terminal" },
  { "<C-_>", "<C-\\><C-n><cmd>lua require('FTerm').toggle()<cr>", mode = "t", desc = "Open Float Terminal" },
}

function M.init()
  vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "FTerm",
    callback = function()
      vim.opt_local.spell = false
    end,
  })
end

M.opts = {
  border = "rounded",
  hl = "NormalFloat",
}

return M
