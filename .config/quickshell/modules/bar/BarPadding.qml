import Quickshell
import Quickshell.Wayland

import "root:config.js" as Config

Variants {
    model: Quickshell.screens
    PanelWindow {
        required property ShellScreen modelData
        screen: modelData
        WlrLayershell.layer: WlrLayer.Background

        anchors {
            left: true
            right: true
            top: true
        }

        exclusiveZone: Config.bar.height
        color: "transparent"
    }
}
