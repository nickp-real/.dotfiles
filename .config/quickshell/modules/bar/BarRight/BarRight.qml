import QtQuick
import Quickshell
import qs.modules.bar.components.dashboard
import qs.modules.bar.components

import "root:config.js" as Config

Variants {
    model: Quickshell.screens

    PanelWindow {
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

        implicitHeight: 800
        implicitWidth: 320

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
                        target: container
                        implicitHeight: Config.bar.height
                        implicitWidth: idle.implicitWidth + Config.padding * 2
                    }
                },
                State {
                    name: "dashboard"
                    PropertyChanges {
                        target: container
                        implicitHeight: 800
                        implicitWidth: 320
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
                anchors.verticalCenter: parent.verticalCenter
            }

            Dashboard {
                id: dashboard
                state: container.containerState === "dashboard" ? "visible" : "hidden"
                anchors.fill: parent
            }
        }
    }
}
