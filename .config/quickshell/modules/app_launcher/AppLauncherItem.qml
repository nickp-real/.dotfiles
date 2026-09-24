import QtQuick
import QtQuick.Layouts
import qs.components

import "root:config.js" as Config

Rectangle {
    id: item
    required property string name
    required property string icon
    required property string description
    required property string entryId
    property bool isCurrentItem: ListView.isCurrentItem
    property bool isSettled: false

    width: ListView.view.width
    implicitHeight: rowItem.implicitHeight + Config.padding * 2
    color: isCurrentItem ? Config.colors.accentFg : "transparent"

    Component.onCompleted: Qt.callLater(() => item.isSettled = true)

    Behavior on color {
        enabled: item.isSettled
        ColorAnimation {
            duration: 100
        }
    }

    RowLayout {
        id: rowItem

        anchors.fill: parent
        anchors.leftMargin: Config.padding
        spacing: Config.padding

        Item {
            width: icon.width
            height: icon.height
            Icon {
                id: icon
                anchors.fill: parent
                source: item.icon
                colorization: false
            }
        }
        Text {
            Layout.fillWidth: true
            text: item.name
            font.family: Config.font.family
            font.pixelSize: Config.font.base
            color: item.isCurrentItem ? Config.colors.accentBg : Config.colors.fg
            Behavior on color {
                enabled: item.isSettled
                ColorAnimation {
                    duration: 100
                }
            }
        }
    }
}
