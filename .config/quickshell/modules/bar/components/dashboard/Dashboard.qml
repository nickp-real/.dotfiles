import QtQuick
import QtQuick.Layouts
import "./components"

import "root:config.js" as Config

Item {
    id: dashboard
    anchors.fill: parent

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
