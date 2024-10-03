local cmd = {}

cmd.ns = vim.api.nvim_create_namespace("cmd")
cmd.buf = vim.api.nvim_create_buf(false, true)
cmd.win = nil
cmd.cursor = nil
cmd.state = {}

cmd.update_state = function(state) cmd.state = vim.tbl_extend("force", cmd.state, state) end

cmd.open = function()
  local columns = vim.o.columns
  local lines = vim.o.lines
  local width_multiplier = 0.6
  local width = math.floor(columns * width_multiplier)
  local height = 1

  -- if cmd.win and vim.api.nvim_win_is_valid(cmd.win) then end

  cmd.win = vim.api.nvim_open_win(cmd.buf, false, {
    relative = "editor",
    row = math.floor((lines - (height + 2)) / 2),
    columns = math.floor((columns - width) / 2),
    width = width,
    height = height,
    zindex = 250,
    border = vim.g.border,
  })

  vim.wo[cmd.win].number = false
  vim.wo[cmd.win].relativenumber = false
  vim.wo[cmd.win].statuscolumn = ""

  vim.wo[cmd.win].wrap = false
  vim.wo[cmd.win].spell = false
  vim.wo[cmd.win].cursorline = false
  vim.wo[cmd.win].sidescrolloff = 10

  vim.bo[cmd.buf].filetype = "vim"
  cmd.cursor = vim.opt.guicursor
  vim.opt.guicursor = "a:CursorHidden"
end

cmd.close = function()
  if cmd.state.level > 1 then return end

  pcall(vim.api.nvim_win_close, cmd.win, true)

  cmd.win = nil
  vim.opt.guicursor = cmd.cursor
end

cmd.redraw = function() vim.api.nvim__redraw({ win = cmd.win, flush = true }) end

cmd.draw = function()
  if not cmd.state or not cmd.state.content then return end

  local text = ""
  for _, part in ipairs(cmd.state.content) do
    text = text .. part[2]
  end

  vim.api.nvim_buf_set_lines(cmd.buf, 0, -1, false, { text })
  vim.api.nvim_win_set_cursor(cmd.win, { 1, cmd.state.position })

  if cmd.state.position >= #text then
    vim.api.nvim_buf_set_extmark(
      cmd.buf,
      cmd.ns,
      0,
      #text,
      { virt_text_pos = "inline", virt_text = { { " ", "Cursor" } } }
    )
  else
    local before = string.sub(text, 0, cmd.state.position)
    vim.api.nvim_buf_add_highlight(
      cmd.buf,
      cmd.ns,
      "Cursor",
      0,
      cmd.state.position,
      #vim.fn.strcharpart(text, 0, vim.fn.strchars(before) + 1)
    )
  end
end

vim.ui_attach(cmd.ns, { ext_cmdline = true }, function(event, ...)
  if event == "cmdline_show" then
    local content, pos, firstc, prompt, indent, level = ...
    cmd.update_state({
      content = content,
      position = pos,
      firstc = firstc,
      prompt = prompt,
      indent = indent,
      level = level,
    })
    cmd.open()
    cmd.draw()
    cmd.redraw()
  elseif event == "cmdline_hide" then
    cmd.close()
    cmd.redraw()
  elseif event == "cmdline_close" then
  elseif event == "cmdline_pos" then
    cmd.draw()
    cmd.redraw()
  end
end)
