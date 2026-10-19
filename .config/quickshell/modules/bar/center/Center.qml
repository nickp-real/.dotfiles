import QtQuick
import Quickshell
import qs.modules.bar.components
import qs.modules.bar.center.components
import qs.modules.bar.center.components.notification

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
        implicitHeight: Math.floor(modelData.height * 2 / 3)
        implicitWidth: Math.floor(modelData.width / 3) - 40
        color: "transparent"
        mask: Region {
            item: container
            bottomLeftRadius: Config.bar.radius
            bottomRightRadius: Config.bar.radius
        }
        focusable: container.state !== "idle"

        FadeTimer {
            id: delay
            open.onTriggered: {
                if (container.state === "idle") {
                    container.state = "control-center";
                }
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
            bottomRightRadius: Config.bar.radius
            anchors.horizontalCenter: parent.horizontalCenter

            state: "idle"

            states: [
                State {
                    name: "idle"
                    PropertyChanges {
                        container.implicitWidth: clock.implicitWidth + Config.padding * 2
                        container.implicitHeight: Config.bar.height
                    }
                },
                State {
                    name: "control-center"
                    PropertyChanges {
                        container.implicitWidth: controlCenter.implicitWidth + Config.padding * 2
                        container.implicitHeight: controlCenter.implicitHeight + Config.padding * 2
                    }
                },
                State {
                    name: "notification"
                    PropertyChanges {
                        container.implicitWidth: notification.implicitWidth + Config.padding * 2
                        container.implicitHeight: notification.implicitHeight + Config.padding * 2
                    }
                }
            ]

            Clock {
                id: clock
                shown: container.state === "idle"
            }
            ControlCenter {
                id: controlCenter
                shown: container.state === "control-center"
                onNotifyClicked: {
                    container.state = "notification";
                    delay.enter();
                }
            }
            Notification {
                id: notification
                shown: container.state === "notification"
            }
        }
    }
}
