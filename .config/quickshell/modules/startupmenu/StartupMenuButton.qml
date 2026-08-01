import QtQuick
import qs.components

import "root:config.js" as Config

Button {
    id: root
    required property string icon
    signal action

    onClicked: root.action()

    implicitHeight: Config.startupMenu.button.size
    implicitWidth: Config.startupMenu.button.size

    color: root.isHovered || root.isFocused ? Config.colors.accentFg : Config.colors.mutedBg

    Icon {
        implicitWidth: Config.startupMenu.button.icon.size
        implicitHeight: Config.startupMenu.button.icon.size
        source: root.icon
        color: root.isHovered || root.isFocused ? Config.colors.bg : Config.colors.fg
    }
}
