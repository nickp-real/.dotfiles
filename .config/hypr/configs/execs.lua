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
		"env QS_ICON_THEME=Papirus qs -c " .. QS_CONFIG,
		"udiskie",
		"nm-applet",

		-- Clipboard
		"wl-paste --type text --watch cliphist store", -- Stores only text data
		"wl-paste --type image --watch cliphist store", -- Stores only image data
	}

	for _, cmd in ipairs(cmd_list) do
		hl.exec_cmd(cmd)
	end

	require("scripts.monitor").arrange_monitor()
end)

hl.on("monitor.added", function()
	require("scripts.monitor").arrange_monitor()
end)

hl.on("monitor.removed", function()
	require("scripts.monitor").arrange_monitor()
end)
