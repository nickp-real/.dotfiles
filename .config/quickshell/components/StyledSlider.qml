import QtQuick
import QtQuick.Controls

import "root:config.js" as Config

Slider {
    id: root
    property alias backgroundStyle: backgroundStyle
    property alias progress: progressLayer

    implicitHeight: 16

    background: Rectangle {
        id: backgroundStyle
        color: Config.colors.mutedBg
        radius: Config.radius
    }

    Rectangle {
        id: progressLayer
        width: root.visualPosition * root.width
        height: root.height
        color: Config.colors.accent
        radius: Config.radius
        clip: true
        anchors.verticalCenter: parent.verticalCenter
    }

    handle: Item {
        visible: false
    }
}
