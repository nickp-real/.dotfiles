local status_ok, noice = pcall(require, "noice")
if not status_ok then
  return
end

noice.setup({
  routes = {
    {
      view = "notify",
      filter = { event = "msg_showmode" },
    },
  },

  popupmenu = {
    enabled = true, -- disable if you use something like cmp-cmdline
    ---@type 'nui'|'cmp'
    backend = "cmp", -- backend to use to show regular cmdline completions
    -- You can specify options for nui under `config.views.popupmenu`
  },
})
