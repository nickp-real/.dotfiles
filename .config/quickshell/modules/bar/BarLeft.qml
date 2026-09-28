import QtQuick
import Quickshell
import qs.modules.bar.components

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

        height: Config.bar.height
        implicitWidth: container.implicitWidth
        color: "transparent"

        exclusionMode: ExclusionMode.Ignore

        BarContainer {
            id: container
            bottomRightRadius: Config.bar.radius

            WorkSpaces {
                anchors.centerIn: parent
            }
        }
    }
}
