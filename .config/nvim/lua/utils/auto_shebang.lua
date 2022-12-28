-- Add shebang add the top of the .sh, .py file
local appendLine = function()
  vim.fn.append(1, "")
  vim.fn.append(2, "")
  vim.fn.cursor(3, 0)
end

local cmd = {
  ["sh"] = "bash",
  ["bash"] = "bash",
  ["python"] = "python3",
}

local insert = function()
  local filetype = vim.bo.filetype
  vim.api.nvim_buf_set_lines(0, 0, -1, false, { "#!/usr/bin/env " .. cmd[filetype] })
  appendLine()
end

local group = vim.api.nvim_create_augroup("Auto Shebang", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinEnter", "BufReadPost", "FileType" }, {
  group = group,
  desc = "Insert shebang",
  pattern = { "*.sh", "*.bash", "*.py" },
  callback = function()
    local filepath = vim.fn.expand("%")
    local emptyfile = vim.fn.getfsize(filepath) < 4
    if emptyfile then
      insert()
    end
  end,
})
