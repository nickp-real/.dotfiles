pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs.components

PopupScope {
    id: root
    name: "app-launcher"

    Connections {
        target: AppLauncherEntriesService
        function onLaunched() {
            AppLauncherEntriesService.filteredEntries.clear();
            root.open = false;
        }
    }

    LazyLoader {
        active: root.open
        AppLauncherPanel {
            open: root.open
            onClose: {
                root.open = false;
            }
        }
    }
}
