import QtQuick
import Quickshell
import qs.modules.bar.components
import qs.modules.bar.left.components.workspaces

import "root:config.js" as Config

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property ShellScreen modelData
        screen: modelData

        anchors {
            top: true
            left: true
        }

        implicitHeight: Config.bar.height
        implicitWidth: Math.floor(modelData.width / 3) - 40
        color: "transparent"

        exclusionMode: ExclusionMode.Ignore

        mask: Region {
            item: container
            bottomRightRadius: Config.bar.radius
        }

        BarContainer {
            id: container
            bottomRightRadius: Config.bar.radius

            Workspaces {}
        }
    }
}
