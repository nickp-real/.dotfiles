const script = {
  lock: ["hyprlock", "-q", "--immediate-render"],
  logout: [""],
  suspend: ["systemctl", "suspend"],
  reboot: ["systemctl", "reboot"],
  shutdown: ["systemctl", "poweroff"],
};
