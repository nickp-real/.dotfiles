local M = {}

M.strsplit = function(inputstr)
  return vim.iter(inputstr:gmatch("([^%s]+)")):fold({}, function(acc, str)
    table.insert(acc, str)
    return acc
  end)
end

M.is_plugin_loaded = function(plugin_name)
  return vim.tbl_get(require("lazy.core.config"), "plugins", plugin_name, "_", "loaded")
end

return M
