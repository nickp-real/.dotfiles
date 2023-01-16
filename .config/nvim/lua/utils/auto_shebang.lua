-- Add shebang add the top of the .sh, .py file
local M = {}

function M.setup()
  local appendLine = function()
    vim.fn.append(1, "")
    vim.fn.append(2, "")
    vim.fn.cursor(3, 0)
  end

  local insert = function()
    local filetype = vim.bo.filetype
    local str_split = require("utils").str_split
    vim.api.nvim_buf_set_lines(
      0,
      0,
      -1,
      false,
      { "#!/usr/bin/env " .. str_split(require("utils.code_cmd").run_command_table[filetype])[1] }
    )
    appendLine()
  end

  local group = vim.api.nvim_create_augroup("Auto Shebang", { clear = true })
  vim.api.nvim_create_autocmd({ "BufWinEnter", "BufReadPost", "FileType" }, {
    group = group,
    desc = "Insert shebang",
    pattern = { "*.sh", "*.bash", "*.py" },
    once = true,
    callback = function()
      local filepath = vim.fn.expand("%")
      local emptyfile = vim.fn.getfsize(filepath) < 4
      if emptyfile then
        insert()
      end
    end,
  })
end

return M
