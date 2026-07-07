import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import qs.modules.bar.components
import qs.modules.bar.components.dashboard
import qs.commons

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

            implicitHeight: Theme.bar.height
            color: "transparent"

            BarLeft {
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height
            }
            BarCenter {
                anchors.centerIn: parent
                height: parent.height
            }
            BarRight {
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height
            }

            Dashboard {
                bar: root
            }
        }
    }
}
