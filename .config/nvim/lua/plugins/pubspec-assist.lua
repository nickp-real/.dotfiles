local status_ok, pubspec_assist = pcall(require, "pubspec-assist")
if not status_ok then
  return
end

pubspec_assist.setup()
