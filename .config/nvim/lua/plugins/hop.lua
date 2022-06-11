local status_ok, hop = pcall(require, "hop")
if not status_ok then
  return
end

-- you can configure Hop the way you like here; see :h hop-config
hop.setup({ keys = "etovxqpdygfblzhckisuran" })
