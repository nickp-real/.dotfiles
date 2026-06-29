pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property int brightness
    property int maxBrightness
    property real percent: recalculatePercent(brightness)

    Process {
        command: ["brightnessctl", "get"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.brightness = this.text
        }
    }

    Process {
        command: ["brightnessctl", "m"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: root.maxBrightness = this.text
        }
    }

    Process {
        id: setBrightnessProcess
        running: false
    }

    function setValue(value) {
        setBrightnessProcess.command = ["brightnessctl", "set", value];
        setBrightnessProcess.running = true;
        root.percent = recalculatePercent(value);
    }

    function recalculatePercent(value) {
        if (maxBrightness === 0)
            return 0;
        return value / maxBrightness;
    }
}
