import QtQuick
import QtQuick.Layouts

import qs.components

import "root:config.js" as Config

ColumnLayout {
    id: root
    required property string title
    property alias icon: icon

    spacing: 4

    RowLayout {
        spacing: 4
        Icon {
            id: icon
        }
        Text {
            text: root.title
            font.pixelSize: Config.font.lg
            font.family: Config.font.family
            color: Config.colors.fg
        }
    }
}
