import QtQuick
import QtQuick.Controls

import "root:config.js" as Config

ScrollBar {
    id: root
    property bool show: root.active || root.hovered
    policy: ScrollBar.AsNeeded
    contentItem: Rectangle {
        opacity: root.show ? 1 : 0
        implicitWidth: 8
        color: Config.colors.accentFg
        radius: Config.radius

        Behavior on opacity {
            // enabled: !root.show
            NumberAnimation {
                duration: 500
                easing.type: Easing.OutCubic
            }
        }
    }
}
