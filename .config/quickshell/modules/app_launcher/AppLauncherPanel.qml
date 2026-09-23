import Quickshell
import QtQuick
import QtQuick.Controls
import qs.components

import "root:config.js" as Config

PopupPanelWindow {
    id: root

    focusable: open
    visible: open

    onClose: AppLauncherEntriesService.filteredEntries.clear()

    implicitWidth: 600
    implicitHeight: container.implicitHeight
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore

    anchors {
        top: true
    }
    margins {
        top: Math.max(200, root.screen.height * 0.25)
    }

    AppLauncherContainer {
        id: container
        open: root.open
    }
}
