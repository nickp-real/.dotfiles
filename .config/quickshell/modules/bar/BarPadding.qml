import Quickshell

import "root:config.js" as Config

Variants {
    model: Quickshell.screens
    PanelWindow {
        required property ShellScreen modelData
        screen: modelData

        anchors {
            left: true
            right: true
            top: true
        }

        implicitHeight: Config.bar.height
        exclusiveZone: Config.bar.height
        color: "transparent"
    }
}
