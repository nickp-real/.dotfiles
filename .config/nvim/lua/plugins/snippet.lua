vim.keymap.set({ "i", "s" }, "<C-j>", function()
  if vim.snippet.active({ direction = 1 }) then
    return vim.schedule(function() vim.snippet.jump(1) end)
  elseif require("neogen").jumpable() then
    return require("neogen").jump_next()
  else
    return "<Esc>:m .+1<CR>==gi"
  end
end, {
  silent = true,
  expr = not (vim.snippet.active({ direction = 1 }) or package.loaded["neogen"] and require("neogen").jumpable())
    and true,
  desc = "Jump to next snippet position or move entire line down",
})

vim.keymap.set({ "i", "s" }, "<C-k>", function()
  if vim.snippet.active({ direction = -1 }) then
    return vim.schedule(function() vim.snippet.jump(-1) end)
  elseif require("neogen").jumpable(true) then
    return require("neogen").jump_prev()
  else
    return "<Esc>:m .-2<CR>==gi"
  end
end, {
  silent = true,
  expr = not (
      vim.snippet.active({ direction = -1 }) or package.loaded["neogen"] and require("neogen").jumpable(true)
    ) and true,
  desc = "Jump to previous snippet position or move entire line up",
})

return {
  {
    "garymjr/nvim-snippets",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = { friendly_snippets = true },
  },

  -- Description generator
  {
    "danymat/neogen",
    cmd = "Neogen",
    opts = { snippet_engine = "nvim" },
  },
}
