local M = {
  "krivahtoo/silicon.nvim",
  build = "./install.sh build",
  name = "silicon",
  cmd = "Silicon",
}

function M.config()
  require("silicon").setup({
    font = "FantasqueSansMono Nerd Font=14",
  })
end

return M
