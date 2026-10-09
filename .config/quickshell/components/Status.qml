import QtQuick
import qs.components

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

        StyledText {
            anchors.verticalCenter: parent.verticalCenter
            text: `${root.value}%`
            width: 32
            horizontalAlignment: Text.AlignRight
        }
    }
}
