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
        }

        exclusionMode: ExclusionMode.Ignore
        implicitHeight: Config.bar.height
        implicitWidth: container.implicitWidth
        color: "transparent"

        BarContainer {
            id: container
            bottomLeftRadius: Config.bar.radius
            bottomRightRadius: Config.bar.radius

            Item {
                implicitHeight: parent.height
                implicitWidth: 204 + Config.padding * 2
                anchors.horizontalCenter: parent.horizontalCenter

                Clock {
                    anchors.centerIn: parent
                }
            }
        }
    }
}
