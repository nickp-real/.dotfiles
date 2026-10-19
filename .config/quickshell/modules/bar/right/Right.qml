import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.bar.components
import qs.modules.bar.right.components
import qs.modules.bar.right.components.dashboard

import "root:config.js" as Config

Variants {
    model: Quickshell.screens

    PanelWindow {
        id: panel
        required property ShellScreen modelData
        screen: modelData

        anchors {
            top: true
            right: true
        }

        exclusionMode: ExclusionMode.Ignore
        color: "transparent"

        mask: Region {
            item: container
            bottomLeftRadius: Config.bar.radius
        }

        implicitHeight: Math.floor(modelData.height * 2 / 3)
        implicitWidth: Math.floor(modelData.width / 3) - 40
        focusable: container.state === "dashboard"

        FadeTimer {
            id: delay
            open.onTriggered: {
                container.state = "dashboard";
            }
            close.onTriggered: {
                container.state = "idle";
            }
        }

        HoverHandler {
            onHoveredChanged: {
                if (hovered) {
                    delay.enter();
                } else {
                    delay.exit();
                }
            }
        }

        BarContainer {
            id: container
            bottomLeftRadius: Config.bar.radius
            anchors.right: parent.right

            state: "idle"
            states: [
                State {
                    name: "idle"
                    PropertyChanges {
                        container.implicitHeight: Config.bar.height
                        container.implicitWidth: idle.implicitWidth + Config.padding * 2
                    }
                },
                State {
                    name: "dashboard"
                    PropertyChanges {
                        container.implicitHeight: panel.implicitHeight
                        container.implicitWidth: panel.implicitWidth
                    }
                }
            ]

            Idle {
                id: idle
                shown: container.state === "idle"
            }

            Dashboard {
                id: dashboard
                shown: container.state === "dashboard"
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
