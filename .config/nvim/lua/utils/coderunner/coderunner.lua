local cmd = require("utils.coderunner.command")
local utils = require("utils")

-- To run file run :Run or just press <F5>
function _G.run_code()
  if cmd.run_command_table[vim.bo.filetype] then
    vim.cmd("2TermExec cmd='" .. cmd.run_command_table[vim.bo.filetype] .. "' direction='float'")
  else
    print("\nFileType not supported\n")
  end
end

-- Use the following function to update the execution command of a filetype temporarly
-- Usage :RunUpdate  --OR-- :RunUpdate filetype
-- If no argument is provided, the command is going to take the filetype of active buffer
function _G.update_command_table(filetype)
  local command

  if filetype == nil then
    filetype = vim.bo.filetype
  end

  filetype = utils.strsplit(filetype)[1]

  if cmd.run_command_table[filetype] then
    command = vim.fn.input(
      string.format("Update run command of filetype (%s): ", filetype),
      cmd.run_command_table[filetype],
      "file"
    )
  else
    command = vim.fn.input(string.format("Add new run command of filetype (%s): ", filetype))
  end

  if #command ~= 0 then
    cmd.run_command_table[filetype] = command
    print("  Updated!")
  end
end

-- Normal run code, output through terminal
vim.api.nvim_create_user_command("Run", "lua run_code()", {})
vim.api.nvim_create_user_command("RunUpdate", "lua update_command_table(<f-args>)", {})
-- vim.cmd("command! -nargs=* RunUpdate :lua update_command_table(<f-args>)")
