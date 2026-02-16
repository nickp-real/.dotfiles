import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import qs.commons
import qs.components

RowLayout {
    id: root

    property color bg: Theme.mutedBg
    property color fg: Theme.accentFg
    property int radius: Theme.radius

    property alias slider: slider
    property alias icon: icon
    signal iconClick

    Rectangle {
        visible: icon.source != ""
        width: Theme.slider.width
        height: Theme.slider.height
        radius: Theme.slider.radius

        color: Theme.mutedBg

        Icon {
            id: icon
            width: Theme.slider.icon.width
            height: Theme.slider.icon.height

            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            MouseArea {
                anchors.fill: parent
                onClicked: root.iconClick()
            }
        }
    }

    Slider {
        id: slider

        from: 0
        to: 100
        value: 0

        height: 16
        Layout.fillWidth: true

        background: Rectangle {
            color: root.bg
            radius: root.radius
        }

        Rectangle {
            width: slider.visualPosition * slider.width
            height: Math.min(slider.height, width)
            color: root.fg
            radius: root.radius
            clip: true
            anchors.verticalCenter: parent.verticalCenter
        }

        handle: Item {
            visible: false
        }
    }
}
