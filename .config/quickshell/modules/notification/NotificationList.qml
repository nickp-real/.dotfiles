import Quickshell
import QtQuick
import QtQuick.Layouts

import "root:config.js" as Config

PanelWindow {
    anchors {
        top: true
        right: true
    }
    margins {
        top: Config.bar.height + Config.padding
        right: Config.padding
    }

    implicitWidth: 380
    implicitHeight: Math.max(1, column.implicitHeight)
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore

    ColumnLayout {
        id: column
        width: parent.width
        spacing: 10

        Repeater {
            model: NotificationService.notifications
            delegate: NotificationCard {}
        }
    }
}
