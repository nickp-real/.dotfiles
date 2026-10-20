import qs.components

import "root:config.js" as Config

Button {
    id: root
    required property string iconSource

    implicitHeight: parent.implicitHeight
    implicitWidth: implicitHeight
    hoverEnabled: true
    style.color: enabled && hovered ? Config.colors.hoverBg : Config.colors.surface

    Icon {
        anchors.centerIn: parent
        source: root.iconSource
        opacity: root.enabled ? 1 : 0.6
    }
}
