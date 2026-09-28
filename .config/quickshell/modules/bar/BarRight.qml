import QtQuick
import Quickshell
import qs.modules.bar.components.dashboard
import qs.modules.bar.components
import qs.services

import qs.components

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
        }

        implicitHeight: 800
        implicitWidth: 800

        BarContainer {
            id: container
            bottomLeftRadius: Config.bar.radius
            anchors.top: parent.top
            anchors.right: parent.right

            property string containerState: "idle"

            state: containerState
            states: [
                State {
                    name: "idle"
                    PropertyChanges {
                        target: container
                        implicitHeight: Config.bar.height
                        implicitWidth: statusRow.implicitWidth + Config.padding * 2
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

            Behavior on implicitWidth {
                NumberAnimation {
                    duration: 300
                    easing: Easing.OutExpo
                }
            }
            Behavior on implicitHeight {
                NumberAnimation {
                    duration: 300
                    easing: Easing.OutExpo
                }
            }

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

            Row {
                id: statusRow
                visible: container.containerState === "idle"
                anchors.verticalCenter: parent.verticalCenter
                spacing: Config.padding
                Status {
                    value: VolumeService.volume * 100
                    icon.source: VolumeService.icon
                }
                Status {
                    value: PowerService.percentage * 100
                    icon.source: PowerService.icon
                }
            }

            Dashboard {
                id: dashboard
                visible: container.containerState === "dashboard"
                anchors.fill: parent
            }
        }
    }
}
