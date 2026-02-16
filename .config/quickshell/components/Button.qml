import QtQuick
import qs.commons

Rectangle {

    property bool isActive: false
    property bool isHovered: hover.hovered

    radius: Theme.innerRadius
    color: Theme.bg

    Behavior on color {
        ColorAnimation {
            duration: 100
        }
    }

    HoverHandler {
        id: hover
    }
}
