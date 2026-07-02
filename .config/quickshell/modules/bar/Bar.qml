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

            RowLayout {
                anchors {
                    fill: parent
                    leftMargin: Theme.bar.leftRightGap
                    rightMargin: Theme.bar.leftRightGap
                    topMargin: Theme.bar.topBottomGap
                    // bottomMargin: Theme.bar.topBottomGap
                }

                BarBox {
                    Layout.fillWidth: true
                    BarLeft {}
                }

                BarBox {
                    Layout.fillWidth: true
                    BarCenter {}
                }

                BarBox {
                    Layout.fillWidth: true
                    BarRight {}
                }
            }

            Dashboard {
                bar: bar
            }
        }
    }
}
