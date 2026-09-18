import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.components

import "root:config.js" as Config

RowLayout {
    id: root

    property color bg: Config.colors.mutedBg
    property color fg: Config.colors.accentFg
    property int radius: Config.radius

    property alias slider: slider
    property alias icon: icon
    signal iconClick

    property bool readonly: false

    Rectangle {
        visible: icon.source != ""
        width: Config.slider.width
        height: Config.slider.height
        radius: Config.slider.radius

        color: Config.colors.mutedBg

        Icon {
            id: icon
            width: Config.slider.icon.width
            height: Config.slider.icon.height

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
            height: slider.height
            color: root.fg
            radius: root.radius
            clip: true
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea {
            anchors.fill: parent
            preventStealing: true
            enabled: root.readonly
            onPressed: mouse => mouse.accepted = true
            onWheel: wheel => wheel.accepted = true
        }

        handle: Item {
            visible: false
        }
    }
}
