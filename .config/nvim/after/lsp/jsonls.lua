local M = {}

M.before_init = function(_, new_config)
  new_config.settings.json.schemas = new_config.settings.json.schemas or {}
  vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
end

M.settings = {
  json = {
    format = { enable = false },
    validate = { enable = true },
  },
}

return M
