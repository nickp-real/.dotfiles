local M = {}

local max_monitor_support = 2

---@param monitors HL.Monitor[]
local function get_another_monitor(monitors)
	for _, monitor in ipairs(monitors) do
		if monitor.name ~= MAIN_MONITOR then
			return monitor.name
		end
	end
end

---@param main string monitor.name
---@param sec string monitor.name
local function bind_workspace_to_monitor(main, sec)
	hl.workspace_rule({ workspace = 1, monitor = main, default = true })
	hl.workspace_rule({ workspace = 6, monitor = sec, default = true })

	hl.dispatch(hl.dsp.workspace.move({ workspace = 1, monitor = main }))
	hl.dispatch(hl.dsp.focus({ workspace = 6 }))
	hl.dispatch(hl.dsp.workspace.move({ workspace = 6, monitor = sec }))
	hl.dispatch(hl.dsp.focus({ workspace = 1 }))
	print("done")
end

---@param main string monitor.name
---@param sec string monitor.name
local function arrange_monitor(main, sec)
	hl.monitor({
		output = main,
		mode = "highres",
		position = "0x0",
		scale = 1,
	})
	hl.monitor({
		output = sec,
		mode = "highres",
		position = "auto",
		scale = 1,
	})
end

---@param main string monitor.name
---@param sec string monitor.name
local function arrange(main, sec)
	arrange_monitor(main, sec)
	bind_workspace_to_monitor(main, sec)
end

function M.arrange_monitor()
	local monitors = hl.get_monitors()
	if #monitors == 1 or #monitors > max_monitor_support then
		return
	end

	local another_monitor = get_another_monitor(monitors)

	if another_monitor == nil then
		return
	end

	if another_monitor == HOME_MAIN_MONITOR then
		arrange(another_monitor, MAIN_MONITOR)
	else
		arrange(MAIN_MONITOR, another_monitor)
	end
end

return M
