import QtQuick

import "root:config.js" as Config

Rectangle {
    id: root
    property bool isActive: false
    property bool isHovered: hover.hovered
    property alias hover: hover
    signal clicked

    radius: Config.innerRadius
    color: Config.colors.mutedBg

    implicitWidth: Config.button.width
    implicitHeight: Config.button.height

    Behavior on color {
        ColorAnimation {
            duration: 100
        }
    }

    HoverHandler {
        id: hover
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
