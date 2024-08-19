local M = {}

M.get_dir_name = function()
  local filename = vim.api.nvim_buf_get_name(0)
  return vim.fn.fnamemodify(filename, ":~:.:h")
end

return M
