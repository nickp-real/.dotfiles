pragma ComponentBehavior: Bound
import Quickshell
import QtQuick

import "root:config.js" as Config

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root
            property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: Config.bar.height
            color: "transparent"

            BarLeft {
                anchors.left: parent.left
                height: parent.height
            }
            BarCenter {
                anchors.centerIn: parent
                height: parent.height
            }
            BarRight {
                anchors.right: parent.right
                height: parent.height
            }
        }
    }
}
