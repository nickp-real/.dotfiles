local status_ok, bufresize = pcall(require, "bufresize")
if not status_ok then
  return
end

bufresize.setup()
