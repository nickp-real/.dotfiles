pragma Singleton

import Quickshell
import Quickshell.Io
import QtQml

Singleton {
    id: root
    readonly property alias menus: model

    ListModel {
        id: model
    }

    Component.onCompleted: {
        for (const action of StartupCommand.orders) {
            const entry = StartupCommand.actions[action];
            model.append({
                action,
                icon: entry.icon,
                requireConfirm: entry.requireConfirm
            });
        }
    }

    function runScript(action: string) {
        actionProcess.command = StartupCommand.actions[action].command;
        actionProcess.running = true;
    }

    Process {
        id: actionProcess
        running: false
    }
}
