import QtQuick
import Quickshell
import qs.modules.bar.components
import qs.modules.bar.left.components.workspaces

import "root:config.js" as Config

Variants {
    model: Quickshell.screens

    BarPanel {
        id: root
        anchors {
            top: true
            left: true
        }

        implicitHeight: Config.bar.height
        implicitWidth: Math.floor(modelData.width / 3) - 40

        container.bottomRightRadius: Config.bar.radius

        Workspaces {}
    }
}
