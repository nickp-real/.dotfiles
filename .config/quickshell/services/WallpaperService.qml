pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

import "root:config.js" as Config

Singleton {
    Process {
        id: wallpaperProcess
        running: false

        stdout: SplitParser {
            onRead: data => console.log("awww stdout:", data)
        }
        stderr: SplitParser {
            onRead: data => console.error("awww stderr:", data)
        }
        onExited: (code, status) => {
            if (code === 0)
                return;
            console.warn("Wallpaper changing error code:", code, status);
        }
    }

    function composeChangeWallpaperCommand(screen: ShellScreen, url: string, x: int, y: int): list<string> {
        const {
            type,
            step,
            fps,
            duration,
            bezier
        } = Config.wallpaper.transition;
        const screenRefreshRate = Math.round(Hyprland.monitorFor(screen).lastIpcObject.refreshRate);
        const constrainFps = Math.min(fps, screenRefreshRate);
        return ["awww", "img", "--transition-type", type, "--transition-step", step, "--transition-duration", duration, "--transition-bezier", bezier, "--transition-fps", constrainFps, "--transition-pos", `${x},${y}`, url,];
    }

    function changeWallpaper(screen: ShellScreen, url: string, x: int, y: int) {
        const command = composeChangeWallpaperCommand(screen, url, x, y);
        wallpaperProcess.command = command;
        wallpaperProcess.running = true;
    }
}
