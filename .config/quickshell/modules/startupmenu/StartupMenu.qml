pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import Quickshell.Io

import "root:config.js" as Config

Scope {
    id: root
    property bool open: false
    property string currentAction: ""

    IpcHandler {
        target: "startup-menu"
        function toggle(): void {
            root.open = !root.open;
        }
        function show(): void {
            root.open = true;
        }
        function hide(): void {
            root.open = false;
        }
    }

    function handleOnActionClick(action: string, requireConfirm: bool) {
        root.open = false;
        if (!requireConfirm)
            StartupMenuService.runScript(action);

        if (requireConfirm)
            root.currentAction = action;
    }

    function handleOnConfirmAction(confirm: bool) {
        if (confirm)
            StartupMenuService.runScript(root.currentAction);

        root.currentAction = "";
    }

    LazyLoader {
        active: root.open
        StartupMenuPanel {
            open: root.open
            onActionClick: root.handleOnActionClick
        }
    }

    //  confirm popup
    LazyLoader {
        active: root.currentAction !== ""
        StartupMenuConfirmPanel {
            open: root.currentAction !== ""
            handleOnConfirmAction: root.handleOnConfirmAction
        }
    }
}
