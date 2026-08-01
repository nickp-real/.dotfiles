import QtQuick

import "root:config.js" as Config

Rectangle {
    id: root
    property bool isActived: false
    property bool isHovered: hover.hovered
    property bool isFocused: false
    signal clicked
    signal hoverEntered
    signal hoverExited

    radius: Config.innerRadius
    color: Config.colors.mutedBg

    implicitWidth: Config.button.width
    implicitHeight: Config.button.height

    Behavior on color {
        ColorAnimation {
            duration: 100
        }
    }

    onIsHoveredChanged: {
        if (root.isHovered)
            root.hoverEntered();
        else
            root.hoverExited();
    }

    HoverHandler {
        id: hover
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.clicked()
    }
}
