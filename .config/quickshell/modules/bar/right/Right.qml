import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.modules.bar.components.dashboard
import qs.modules.bar.components
import qs.modules.bar.right.components

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
        focusable: container.containerState === "dashboard"

        BarContainer {
            id: container
            bottomLeftRadius: Config.bar.radius
            anchors.right: parent.right

            property string containerState: "idle"

            state: containerState
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

            transitions: [
                Transition {
                    from: "idle"
                    to: "dashboard"
                    SequentialAnimation {
                        PauseAnimation {
                            duration: 300
                        }
                        NumberAnimation {
                            target: container
                            duration: 150
                            easing: Easing.OutQuad
                            properties: "implicitWidth,implicitHeight"
                        }
                    }
                },
                Transition {
                    from: "dashboard"
                    to: "idle"
                    SequentialAnimation {
                        PauseAnimation {
                            duration: 300
                        }
                        NumberAnimation {
                            target: container
                            duration: 150
                            easing: Easing.OutQuad
                            properties: "implicitWidth,implicitHeight"
                        }
                    }
                }
            ]

            Timer {
                id: openDelay
                interval: 80
                onTriggered: container.containerState = "dashboard"
            }
            Timer {
                id: closeDelay
                interval: 100
                onTriggered: container.containerState = "idle"
            }

            HoverHandler {
                id: hover
                onHoveredChanged: {
                    if (hovered) {
                        closeDelay.stop();
                        openDelay.restart();
                    } else {
                        openDelay.stop();
                        closeDelay.restart();
                    }
                }
            }

            Idle {
                id: idle
                state: container.containerState === "idle" ? "visible" : "hidden"
            }

            Dashboard {
                id: dashboard
                state: container.containerState === "dashboard" ? "visible" : "hidden"
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }
}
