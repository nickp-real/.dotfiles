import QtQuick
import qs.modules.bar.components
import qs.components
import qs.services

import "root:config.js" as Config

FadeItem {
    id: root
    implicitWidth: 240
    implicitHeight: 40
    signal notifyClicked
    signal musicPlayerClicked

    Row {
        anchors.fill: parent
        spacing: Config.padding

        ControlCenterButton {
            iconSource: "notifications"
            onClicked: root.notifyClicked()
        }

        Divider {
            implicitHeight: parent.height
            implicitWidth: 1
        }

        ControlCenterButton {
            enabled: MusicPlayerService.player !== null
            iconSource: "audio-headphones"
            onClicked: root.musicPlayerClicked()
        }
    }
}
