local status_ok, neotree = pcall(require, "neo-tree")
if not status_ok then
  return
end

neotree.setup({
  filesystem = {
    hijack_netrw_behavior = "open_current",
    follow_current_file = true,
    use_libuv_file_watcher = true,
  },
  event_handlers = {
    {
      event = "file_opened",
      handler = function(file_path)
        --auto close
        require("neo-tree").close_all()
      end,
    },
  },
})
