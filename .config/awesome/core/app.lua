local M = {}
local startUp = {
	"flameshot",
	"copyq",
}

local startUpWithShell = {
	"libinput-gestures-setup start &",
	"picom &",
}

local default = {
	rofi = "launcher_t1",
	powermenu = "powermenu_t3",
}

M.startUp = startUp
M.startUpWithShell = startUpWithShell
M.defaultApp = default

return M
