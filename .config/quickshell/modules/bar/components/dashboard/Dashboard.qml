import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "./components"
import qs.commons

import "root:config.js" as Config

PopupWindow {
    id: root
    required property var window
    anchor.window: root.window
    anchor.rect.x: root.window.width - Config.bar.leftRightGap - width
    anchor.rect.y: Config.bar.height + Config.bar.topBottomGap

    implicitHeight: 160
    implicitWidth: 240
    color: "transparent"

    visible: GlobalStates.dashboardOpen

    // HyprlandFocusGrab {
    //     active: GlobalStates.dashboardOpen
    //     windows: [root]
    //     onCleared: {
    //         // closeAnimation.start();
    //         // GlobalStates.dashboardOpen = false;
    //     }
    // }

    Rectangle {
        id: dashboard
        anchors.fill: parent
        color: Config.colors.bg
        radius: Config.radius

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 8

            VolumeSlide {}
            BrightnessSlide {}
            Battery {}
            SystemTray {
                window: root.window
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
