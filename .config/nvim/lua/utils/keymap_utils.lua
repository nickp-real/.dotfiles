local M = {}

M.bind = function(op, outer_opts)
  outer_opts = vim.tbl_extend("force", { silent = true }, outer_opts or {})
  return function(lhs, rhs, opts)
    opts = vim.tbl_extend("force", outer_opts, opts or {})
    vim.keymap.set(op, lhs, rhs, opts)
  end
end

M.nmap = M.bind("n", { noremap = false })
M.nnoremap = M.bind("n")
M.vnoremap = M.bind("v")
M.xnoremap = M.bind("x")
M.inoremap = M.bind("i")
M.innoremap = M.bind({ "i", "n" })
M.nvnoremap = M.bind({ "n", "v" })
M.nxnoremap = M.bind({ "n", "x" })
M.nxonoremap = M.bind({ "n", "x", "o" })

return M
