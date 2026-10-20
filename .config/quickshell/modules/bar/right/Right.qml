import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.bar.components
import qs.modules.bar.right.components
import qs.modules.bar.right.components.dashboard

import "root:config.js" as Config

Variants {
    model: Quickshell.screens

    BarPanel {
        id: root
        implicitHeight: Math.floor(modelData.height * 2 / 3)
        implicitWidth: Math.floor(modelData.width / 3) - 40
        focusable: container.state === "dashboard"

        anchors {
            top: true
            right: true
        }

        onOpenTriggered: {
            root.container.state = "dashboard";
        }
        onCloseTriggered: {
            root.container.state = "idle";
        }

        container.anchors.right: container.parent.right
        container.bottomLeftRadius: Config.bar.radius

        container.state: "idle"
        container.states: [
            State {
                name: "idle"
                PropertyChanges {
                    root.container.implicitHeight: Config.bar.height
                    root.container.implicitWidth: idle.implicitWidth + Config.padding * 2
                }
            },
            State {
                name: "dashboard"
                PropertyChanges {
                    root.container.implicitHeight: root.implicitHeight
                    root.container.implicitWidth: root.implicitWidth
                }
            }
        ]

        Idle {
            id: idle
            shown: root.container.state === "idle"
        }

        Dashboard {
            id: dashboard
            shown: root.container.state === "dashboard"
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
