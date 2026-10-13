import QtQuick
import qs.components

import "root:config.js" as Config

Button {
    id: root
    required property bool scanning
    implicitWidth: refreshIcon.width + Config.padding
    implicitHeight: implicitWidth

    Icon {
        id: refreshIcon
        source: "refresh.svg"
        anchors.centerIn: parent

        RotationAnimator on rotation {
            from: 0
            to: 360
            duration: 900
            loops: Animation.Infinite
            running: root.scanning
            onStopped: refreshIcon.rotation = 0
        }
    }
}
