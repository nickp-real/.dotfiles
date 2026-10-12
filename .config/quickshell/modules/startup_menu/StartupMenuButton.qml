import QtQuick
import qs.components

import "root:config.js" as Config

Button {
    id: root
    required property string iconSource

    implicitHeight: Config.startupMenu.button.size
    implicitWidth: Config.startupMenu.button.size

    hoverEnabled: true
    style.color: root.hovered || root.highlighted ? Config.colors.accent : Config.colors.surface

    Icon {
        anchors.centerIn: parent
        implicitWidth: Config.startupMenu.button.icon.size
        implicitHeight: Config.startupMenu.button.icon.size
        source: root.iconSource
        color: root.hovered || root.highlighted ? Config.colors.onAccent : Config.colors.text
    }
}
