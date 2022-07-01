local M = {}

local status_ok, schemastore = pcall(require, "schemastore")
if not status_ok then
  return
end

M.settings = {
  json = {
    schemas = schemastore.json.schemas(),
    validate = { enable = true },
  },
}

return M
