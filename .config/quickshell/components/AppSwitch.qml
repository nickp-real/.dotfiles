import QtQuick
import QtQuick.Controls

import "root:config.js" as Config

Switch {
    id: root

    indicator: Rectangle {
        implicitWidth: 48
        implicitHeight: 26
        x: root.leftPadding
        y: parent.height / 2 - height / 2
        radius: 13
        color: root.checked ? Config.colors.accent : Config.colors.text
        border.color: root.checked ? Config.colors.accent : Config.colors.text

        Rectangle {
            x: root.checked ? parent.width - width : 0
            width: radius * 2
            height: radius * 2
            radius: parent.implicitHeight / 2
            color: root.down ? Config.colors.text : Config.colors.mutedFg
            border.color: root.checked ? (root.down ? Config.colors.mutedFg : Config.colors.text) : Config.colors.text
        }
    }
}
