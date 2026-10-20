import QtQuick
import Quickshell
import qs.modules.bar.components
import qs.modules.bar.center.components
import qs.modules.bar.center.components.notification
import qs.modules.bar.center.components.music_player

import "root:config.js" as Config

Variants {
    model: Quickshell.screens

    BarPanel {
        id: root
        anchors {
            top: true
        }

        implicitHeight: Math.floor(modelData.height * 2 / 3)
        implicitWidth: Math.floor(modelData.width / 3) - 40

        onOpenTriggered: {
            if (container.state === "idle") {
                root.container.state = "control-center";
            }
        }
        onCloseTriggered: {
            root.container.state = "idle";
        }

        container.bottomLeftRadius: Config.bar.radius
        container.bottomRightRadius: Config.bar.radius
        container.anchors.horizontalCenter: container.parent.horizontalCenter

        container.state: "idle"

        container.states: [
            State {
                name: "idle"
                PropertyChanges {
                    root.container.implicitWidth: clock.implicitWidth + Config.padding * 2
                    root.container.implicitHeight: Config.bar.height
                }
            },
            State {
                name: "control-center"
                PropertyChanges {
                    root.container.implicitWidth: controlCenter.implicitWidth + Config.padding * 2
                    root.container.implicitHeight: controlCenter.implicitHeight + Config.padding * 2
                }
            },
            State {
                name: "notification"
                PropertyChanges {
                    root.container.implicitWidth: notification.implicitWidth + Config.padding * 2
                    root.container.implicitHeight: notification.implicitHeight + Config.padding * 2
                }
            },
            State {
                name: "music-player"
                PropertyChanges {
                    root.container.implicitWidth: musicPlayer.implicitWidth + Config.padding * 2
                    root.container.implicitHeight: musicPlayer.implicitHeight + Config.padding * 2
                }
            }
        ]

        Clock {
            id: clock
            shown: root.container.state === "idle"
        }
        ControlCenter {
            id: controlCenter
            shown: root.container.state === "control-center"
            onNotifyClicked: {
                root.container.state = "notification";
                root.delay.enter();
            }
            onMusicPlayerClicked: {
                root.container.state = "music-player";
                root.delay.enter();
            }
        }
        Notification {
            id: notification
            shown: root.container.state === "notification"
        }
        MusicPlayer {
            id: musicPlayer
            shown: root.container.state === "music-player"
        }
    }
}
