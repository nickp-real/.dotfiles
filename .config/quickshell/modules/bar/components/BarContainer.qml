import QtQuick

import "root:config.js" as Config

Rectangle {
    default property alias content: row.data

    color: Config.colors.bg
    implicitHeight: Config.bar.height
    implicitWidth: row.implicitWidth + Config.padding * 2

    Row {
        id: row
        spacing: Config.padding
        anchors.fill: parent
        anchors.margins: Config.padding
    }
}
