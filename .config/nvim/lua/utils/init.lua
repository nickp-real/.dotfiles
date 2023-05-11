local M = {}

function M.strsplit(inputstr)
  local t = {}
  for str in string.gmatch(inputstr, "([^%s]+)") do
    table.insert(t, str)
  end
  return t
end

function M.notify(text, title)
  vim.notify(text, nil, { title = title })
end

return M
