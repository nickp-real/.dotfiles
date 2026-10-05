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
            AppLauncherEntriesService.clear();
            root.open = false;
        }
    }

    Loader {
        active: root.open
        sourceComponent: AppLauncherPanel {
            open: root.open
            onClose: {
                root.open = false;
            }
        }
    }
}
