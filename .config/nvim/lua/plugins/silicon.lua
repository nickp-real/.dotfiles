local M = {
  "krivahtoo/silicon.nvim",
  build = "./install.sh build",
  name = "silicon",
  cmd = "Silicon",
}

function M.config(_, opts)
  require("silicon").setup(opts)
end

M.opts = {
  font = "Roboto Mono=14",
}

return M
