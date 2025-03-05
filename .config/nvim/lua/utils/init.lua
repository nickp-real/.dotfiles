local M = {}

M.strsplit = function(inputstr)
  local t = {}
  for str in string.gmatch(inputstr, "([^%s]+)") do
    table.insert(t, str)
  end
  return t
end

M.is_plugin_loaded = function(plugin_name)
  return vim.tbl_get(require("lazy.core.config"), "plugins", plugin_name, "_", "loaded")
end

return M
