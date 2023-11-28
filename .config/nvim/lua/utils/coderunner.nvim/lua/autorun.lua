local M = {}
local cmd = require("utils.code_cmd")
local utils = require("utils")

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

function M.setup()
  -- Buffers
  local resultBufnr, inputBufnr

  -- AutoRun
  vim.api.nvim_create_user_command("AutoRun", function()
    local file = vim.fn.expand("%")
    local default = vim.fn.expandcmd(cmd.run_command_table[vim.bo.ft])
    vim.ui.input({ prompt = "Command: ", default = default }, function(input)
      if not input then
        return
      end

      if not resultBufnr then
        utils.notify("AutoRun Starts Now!", "AutoRun")
        vim.cmd.vnew()
        vim.cmd.setlocal("nobuflisted buftype=nofile bufhidden=wipe noswapfile")
        resultBufnr = vim.api.nvim_get_current_buf()
        vim.cmd.wincmd("p")
      else
        vim.api.nvim_del_augroup_by_name("AutoRun")
        utils.notify("AutoRun Command Changed!", "AutoRun")
      end

      local pattern = cmd.pattern_table[vim.bo.filetype]
      attach_to_buffer(tonumber(resultBufnr), pattern, file, input)
    end)
  end, {})

  -- AutoRunCP
  vim.api.nvim_create_user_command("AutoRunCP", function()
    local file = vim.fn.expand("%")
    local default = vim.fn.expandcmd(cmd.run_command_table[vim.bo.ft]) .. " < input.txt"

    vim.ui.input({ prompt = "Command: ", default = default }, function(input)
      if not input then
        return
      end
      if not (resultBufnr and inputBufnr) then
        utils.notify("AutoRunCP Starts Now!", "AutoRunCP")
        vim.cmd.vnew("input.txt")
        vim.cmd.setlocal("nobuflisted noswapfile")
        inputBufnr = vim.api.nvim_get_current_buf()
        vim.cmd.new()
        vim.cmd.setlocal("nobuflisted buftype=nofile bufhidden=wipe noswapfile")
        resultBufnr = vim.api.nvim_get_current_buf()
        vim.cmd.wincmd("h")
      else
        vim.api.nvim_del_augroup_by_name("AutoRun")
        utils.notify("AutoRunCP Command Changed!", "AutoRunCP")
      end

      local pattern = { "input.txt", cmd.pattern_table[vim.bo.filetype] }
      attach_to_buffer(tonumber(resultBufnr), pattern, file, input)
    end)
  end, {})

  -- AutoRunClear
  vim.api.nvim_create_user_command("AutoRunClear", function()
    vim.api.nvim_command("only")
    if resultBufnr then
      resultBufnr = nil
    end
    if inputBufnr then
      inputBufnr = nil
    end

    vim.api.nvim_del_augroup_by_name("AutoRun")
    utils.notify("AutoRun Clear Complete!", "AutoRun")
  end, {})
end

return M
