hl.on("hyprland.start", function()
	local cmd_list = {
		"hyprlock", -- lockscreen at start
		"hyprctl setcursor Bibata-Modern-Ice 24",

		-- Core
		"~/.config/hypr/script/xdg-desktop-portal-hyprland.sh", -- reset XDPH for screenshare
		"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP", -- for XDPH
		"dbus-update-activation-environment --systemd --all", -- for XDPH
		"systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP", --  for XDPH

		-- Program
		"qs -c $qsConfig",
		"udiskie",
		-- "~/.config/hypr/scripts/ipc.sh",
		"sleep 2 && ~/.config/hypr/scripts/monitor.sh",
		"nm-applet",

		-- Clipboard
		"wl-paste --type text --watch cliphist store", -- Stores only text data
		"wl-paste --type image --watch cliphist store", -- Stores only image data
	}

	for _, cmd in ipairs(cmd_list) do
		hl.exec_cmd(cmd)
	end
end)

hl.on("monitor.added", function()
	hl.exec_cmd("~/.config/hypr/scripts/monitor.sh")
end)

hl.on("monitor.removed", function()
	hl.exec_cmd("~/.config/hypr/scripts/monitor.sh")
end)
