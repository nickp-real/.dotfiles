local run_command_table = {
  ["cpp"] = "g++ -Wall -O2 % -o %:r && ./%:r",
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

local pattern_table = {
  ["cpp"] = "*.cpp",
  ["c"] = "*.c",
  ["python"] = "*.py",
  ["lua"] = "*.lua",
  ["java"] = "*.java",
  ["zsh"] = "*.zsh",
  ["sh"] = "*.sh",
  ["rust"] = "*.rust",
  ["go"] = "*.go",
  ["javascript"] = "*.js",
}

local expand = function(str)
  return vim.fn.expand(str)
end

local default_run_command = function(filetype, file, filename)
  local cmd = {
    ["cpp"] = "g++ -Wall -O2 " .. file .. " -o " .. filename .. " && ./" .. filename,
    ["c"] = "gcc " .. file .. " -o " .. filename .. " && ./" .. filename,
    ["python"] = "python " .. file,
    ["lua"] = "lua " .. file,
    ["java"] = "javac " .. file .. " && java " .. filename,
    ["zsh"] = "zsh " .. file,
    ["sh"] = "sh " .. file,
    ["rust"] = "rustc " .. file .. " && ./" .. filename,
    ["go"] = "go run " .. file,
    ["javascript"] = "node " .. file,
  }
  return cmd[filetype]
end

-- To run file run :Run or just press <F5>
function _G.run_code()
  if run_command_table[vim.bo.filetype] then
    vim.cmd("2TermExec cmd='" .. run_command_table[vim.bo.filetype] .. "' direction='float'")
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

local function notify(text, title)
  vim.notify(text, nil, { title = title })
end

-- Use the following function to update the execution command of a filetype temporarly
-- Usage :RunUpdate  --OR-- :RunUpdate filetype
-- If no argument is provided, the command is going to take the filetype of active buffer
function _G.update_command_table(filetype)
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

-- Normal run code, output through terminal
vim.api.nvim_create_user_command("Run", "lua run_code()", {})
vim.api.nvim_create_user_command("RunUpdate", "lua update_command_table(<f-args>)", {})
-- vim.cmd("command! -nargs=* RunUpdate :lua update_command_table(<f-args>)")

-- Run on save
local attach_to_buffer = function(output_bufnr, pattern, file, command)
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("AutoRun", { clear = true }),
    pattern = pattern,
    callback = function()
      local append_data = function(_, data)
        if data then
          vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
        end
      end

      vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, { file .. " output:" })
      vim.fn.jobstart(command, {
        stdout_buffered = true,
        on_stdout = append_data,
        on_stderr = append_data,
      })
    end,
  })
end

-- Buffers
local resultBufnr, inputBufnr
-- AutoRun
vim.api.nvim_create_user_command("AutoRun", function()
  local file = expand("%")
  local filename = expand("%:r")
  local default = default_run_command(vim.bo.filetype, file, filename)
  vim.ui.input({ prompt = "Command: ", default = default }, function(input)
    if not input then
      return
    end

    if not resultBufnr then
      notify("AutoRun Starts Now!", "AutoRun")
      vim.api.nvim_command("vnew | setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile")
      resultBufnr = vim.api.nvim_get_current_buf()
      vim.api.nvim_command("wincmd p")
    else
      notify("AutoRun Command Changed!", "AutoRun")
    end

    local pattern = pattern_table[vim.bo.filetype]
    attach_to_buffer(tonumber(resultBufnr), pattern, file, input)
  end)
end, {})

-- AutoRunCP
vim.api.nvim_create_user_command("AutoRunCP", function()
  local file = expand("%")
  local filename = expand("%:r")
  local default = default_run_command(vim.bo.filetype, file, filename) .. " < input.txt"

  vim.ui.input({ prompt = "Command: ", default = default }, function(input)
    if not input then
      return
    end
    if not (resultBufnr and inputBufnr) then
      notify("AutoRunCP Starts Now!", "AutoRunCP")
      vim.api.nvim_command("vnew input.txt")
      inputBufnr = vim.api.nvim_get_current_buf()
      vim.api.nvim_command("new | setlocal nobuflisted buftype=nofile bufhidden=wipe noswapfile")
      resultBufnr = vim.api.nvim_get_current_buf()
      vim.api.nvim_command("wincmd h")
    else
      notify("AutoRunCP Command Changed!", "AutoRunCP")
    end

    local pattern = { "input.txt", pattern_table[vim.bo.filetype] }
    attach_to_buffer(tonumber(resultBufnr), pattern, file, input)
  end)
end, {})

-- AutoRunClear
vim.api.nvim_create_user_command("AutoRunClear", function()
  vim.api.nvim_command("only")
  if resultBufnr then
    vim.api.nvim_command("Bdelete!" .. resultBufnr)
    resultBufnr = nil
  end
  if inputBufnr then
    vim.api.nvim_command("Bdelete!" .. inputBufnr)
    inputBufnr = nil
  end
  notify("AutoRun Clear Complete!", "AutoRun")
end, {})
