pragma ComponentBehavior: Bound
import QtQuick
import Quickshell
import qs.components

PopupScope {
    id: root
    name: "startup-menu"
    property string currentAction: ""

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

    function handleClose() {
        root.open = false;
    }

    LazyLoader {
        active: root.open
        StartupMenuPanel {
            open: root.open
            onActionClick: (action, requireConfirm) => root.handleOnActionClick(action, requireConfirm)
            onRequestClose: root.handleClose()
        }
    }

    //  confirm popup
    LazyLoader {
        active: root.currentAction !== ""
        StartupMenuConfirmPanel {
            open: root.currentAction !== ""
            onConfirmAction: confirm => root.handleOnConfirmAction(confirm)
        }
    }
}
