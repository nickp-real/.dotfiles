import QtQuick
import QtQuick.Layouts

import qs.components

import "root:config.js" as Config

ColumnLayout {
    id: root
    required property string title
    property alias icon: icon
    property alias titleRowContent: space.data

    spacing: Config.padding / 2

    RowLayout {
        spacing: Config.padding / 2

        Icon {
            id: icon
        }
        StyledText {
            text: root.title
            font.pixelSize: Config.font.lg
        }
        Item {
            id: space
            Layout.fillWidth: true
            implicitHeight: parent.height
        }
    }
}
