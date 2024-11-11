local M = {}

M.settings = {
  gopls = {
    buildFlags = { "-tags=wireinject" },
    -- standaloneTags = { "ignore", "wireinject", "!wireinject" },
  },
}

return M
