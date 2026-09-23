import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import qs.components

import "root:config.js" as Config

Rectangle {
    id: root
    required property bool open

    anchors.fill: parent
    color: Config.colors.bg
    radius: Config.radius

    implicitHeight: layout.implicitHeight

    ColumnLayout {
        id: layout
        anchors.fill: parent
        spacing: Config.appLauncher.spacing

        AppLauncherInput {
            open: root.open
            listView: displayList.listView
        }

        AppLauncherDisplayList {
            id: displayList
        }
    }
}
