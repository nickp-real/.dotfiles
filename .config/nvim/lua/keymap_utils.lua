local M = {}

local bind = function(op, outer_opts)
  outer_opts = vim.tbl_extend("force", { silent = true }, outer_opts or {})
  return function(lhs, rhs, opts)
    opts = vim.tbl_extend("force", outer_opts, opts or {})
    vim.keymap.set(op, lhs, rhs, opts)
  end
end

local nmap = bind("n", { noremap = false })
local nnoremap = bind("n")
local vnoremap = bind("v")
local xnoremap = bind("x")
local inoremap = bind("i")
local nvnoremap = bind({ "n", "v" })
local nxnoremap = bind({ "n", "x" })
local nxonoremap = bind({ "n", "x", "o" })

M.bind = bind
M.nmap = nmap
M.nnoremap = nnoremap
M.vnoremap = vnoremap
M.xnoremap = xnoremap
M.inoremap = inoremap
M.nvnoremap = nvnoremap
M.nxnoremap = nxnoremap
M.nxonoremap = nxonoremap

return M
