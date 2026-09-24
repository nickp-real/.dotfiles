import Quickshell
import QtQuick
import QtQuick.Controls
import qs.components

import "root:config.js" as Config

PopupPanelWindow {
    id: root

    focusable: open
    visible: open

    onClose: AppLauncherEntriesService.clear()

    implicitWidth: 600
    implicitHeight: input.implicitHeight
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore

    anchors {
        top: true
    }
    margins {
        top: Math.max(200, root.screen.height * 0.25)
    }

    AppLauncherInput {
        id: input
        open: root.open
        listView: displayList.listView
    }

    AppLauncherDisplayList {
        id: displayList
        anchor.window: root
    }
}
