local status_ok, iswap = pcall(require, "iswap")
if not status_ok then
  return
end

iswap.setup({
  autoswap = true,
})
