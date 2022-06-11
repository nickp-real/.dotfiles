local dap_status_ok, dap = pcall(require, "dap")
local dapui_status_ok, dapui = pcall(require, "dapui")
if not (dap_status_ok and dapui_status_ok) then
  return
end

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
