local run_command_table = {
  ["cpp"] = "g++ % -o %:r && ./%:r",
  ["c"] = "gcc % -o %:r && ./%:r",
  ["python"] = "python %",
  ["lua"] = "lua %",
  ["java"] = "javac % && java %:r",
  ["zsh"] = "zsh %",
  ["sh"] = "sh %",
  ["rust"] = "rustc % && ./%:r",
  ["go"] = "go run %",
  ["javascript"] = "node %",
}

-- To run file run :Run or just press <F5>
function Run_code()
  if run_command_table[vim.bo.filetype] then
    vim.cmd("TermExec cmd='" .. run_command_table[vim.bo.filetype] .. "'")
  else
    print("\nFileType not supported\n")
  end
end

local function strsplit(inputstr)
  local t = {}
  for str in string.gmatch(inputstr, "([^%s]+)") do
    table.insert(t, str)
  end
  return t
end

-- Use the following function to update the execution command of a filetype temporarly
-- Usage :RunUpdate  --OR-- :RunUpdate filetype
-- If no argument is provided, the command is going to take the filetype of active buffer
function Update_command_table(filetype)
  local command

  if filetype == nil then
    filetype = vim.bo.filetype
  end

  filetype = strsplit(filetype)[1]

  if run_command_table[filetype] then
    command = vim.fn.input(
      string.format("Update run command of filetype (%s): ", filetype),
      run_command_table[filetype],
      "file"
    )
  else
    command = vim.fn.input(string.format("Add new run command of filetype (%s): ", filetype))
  end

  if #command ~= 0 then
    run_command_table[filetype] = command
    print("  Updated!")
  end
end

vim.cmd("command! Run :lua Run_code()")

vim.cmd("command! -nargs=* RunUpdate :lua Update_command_table(<f-args>)")
