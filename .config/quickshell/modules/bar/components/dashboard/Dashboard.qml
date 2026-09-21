import QtQuick
import QtQuick.Layouts
import Quickshell
import "./components"

import "root:config.js" as Config

PopupWindow {
    id: root

    implicitHeight: 160
    implicitWidth: 240
    color: "transparent"
    grabFocus: true

    anchor.margins {
        top: Config.bar.height - Config.bar.topBottomGap
        right: -Config.innerRadius
    }
    anchor.edges: Edges.Top | Edges.Right
    anchor.gravity: Edges.Bottom | Edges.Left

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
            SystemTray {}

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
