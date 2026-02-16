import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "./components"
import qs.commons

PopupWindow {
    id: root
    required property var bar
    anchor.window: bar
    anchor.rect.x: bar.width - Theme.bar.leftRightGap - width
    anchor.rect.y: Theme.bar.height + Theme.bar.topBottomGap

    implicitHeight: 100
    implicitWidth: 240
    color: "transparent"

    visible: GlobalStates.dashboardOpen

    HyprlandFocusGrab {
        active: GlobalStates.dashboardOpen
        windows: [root]
        onCleared: {
            // closeAnimation.start();
            GlobalStates.dashboardOpen = false;
        }
    }

    Rectangle {
        id: dashboard
        anchors.fill: parent
        color: Theme.bg
        radius: Theme.radius

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 8

            VolumeSlide {}
            SystemTray {
                window: root.bar
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }

    // SequentialAnimation {
    //     id: closeAnimation
    //     NumberAnimation {
    //         target: dashboard
    //         property: "height"
    //         to: 0
    //         duration: 250
    //     }
    //
    //     ScriptAction {
    //         script: {
    //             GlobalStates.dashboardOpen = false;
    //         }
    //     }
    // }
}
