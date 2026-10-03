pragma Singleton

import Quickshell

Singleton {
    readonly property var actions: ({
            lock: {
                command: ["hyprlock", "-q", "--immediate-render"],
                icon: "lock-icon.svg",
                requireConfirm: false
            },
            logout: {
                command: [""],
                icon: "logout-icon.svg",
                requireConfirm: true
            },
            suspend: {
                command: ["systemctl", "suspend"],
                icon: "pause-icon.svg",
                requireConfirm: true
            },
            reboot: {
                command: ["systemctl", "reboot"],
                icon: "restart-icon.svg",
                requireConfirm: true
            },
            shutdown: {
                command: ["systemctl", "poweroff"],
                icon: "power-icon.svg",
                requireConfirm: true
            }
        })

    readonly property list<string> orders: Object.keys(actions)
}
