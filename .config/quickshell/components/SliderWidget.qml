import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.components

import "root:config.js" as Config

RowLayout {
    id: root

    property color bg: Config.colors.mutedBg
    property color fg: Config.colors.accent
    property int radius: Config.radius

    property alias slider: slider
    property alias icon: sliderIcon
    signal iconClick

    property bool readonly: false

    Button {
        Layout.preferredHeight: Config.slider.height
        Layout.preferredWidth: Config.slider.width
        Layout.alignment: Qt.AlignVCenter
        visible: sliderIcon.source != ""
        enabled: visible || !root.readonly

        style.radius: Config.slider.radius
        onClicked: root.iconClick()

        Icon {
            id: sliderIcon
            implicitWidth: Config.slider.icon.width
            implicitHeight: Config.slider.icon.height
            anchors.centerIn: parent
        }
    }

    StyledSlider {
        id: slider

        from: 0
        to: 100
        value: 0
        enabled: !root.readonly

        Layout.preferredHeight: 16
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter

        backgroundStyle.color: root.bg
        backgroundStyle.radius: root.radius

        progress.color: root.fg
        progress.radius: root.radius
    }
}
