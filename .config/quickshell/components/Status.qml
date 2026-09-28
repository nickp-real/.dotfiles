import QtQuick

import "root:config.js" as Config

Item {
    id: root
    property int value
    property alias icon: icon

    implicitHeight: row.implicitHeight
    implicitWidth: row.implicitWidth

    Row {
        id: row
        spacing: 4

        Icon {
            id: icon
            anchors.verticalCenter: parent.verticalCenter
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            text: `${root.value}%`
            font.family: Config.font.family
            font.pixelSize: Config.font.md
            color: Config.colors.fg
            font.features: {
                "tnum": 1
            }
        }
    }
}
