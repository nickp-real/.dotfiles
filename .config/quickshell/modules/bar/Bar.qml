import Quickshell
import Quickshell.Io
import QtQuick
import qs.modules.bar.components
import qs.modules.bar.components.dashboard
import qs.commons

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
            property var modelData
            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: Theme.bar.height
            color: "transparent"

            Rectangle {
                anchors {
                    fill: parent
                    leftMargin: Theme.bar.leftRightGap
                    rightMargin: Theme.bar.leftRightGap
                    topMargin: Theme.bar.topBottomGap
                    // bottomMargin: Theme.bar.topBottomGap
                }

                color: Theme.bg
                radius: Theme.bar.radius

                BarLeft {}

                BarCenter {}

                BarRight {}
            }

            Dashboard {
                bar: bar
            }
        }
    }
}
