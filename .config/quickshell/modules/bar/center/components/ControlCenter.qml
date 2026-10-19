import QtQuick
import qs.modules.bar.components
import qs.components

import "root:config.js" as Config

FadeItem {
    id: root
    implicitWidth: 240
    implicitHeight: 40
    signal notifyClicked

    Row {
        anchors.fill: parent
        spacing: Config.padding

        Button {
            implicitHeight: parent.implicitHeight
            implicitWidth: implicitHeight
            hoverEnabled: true
            style.color: Config.colors.surface
            onClicked: root.notifyClicked()

            contentItem: Icon {
                source: "notifications"
            }
        }

        Divider {
            implicitHeight: parent.height
            implicitWidth: 1
        }
    }
}
