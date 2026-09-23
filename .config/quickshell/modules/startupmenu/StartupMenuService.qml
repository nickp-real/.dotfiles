pragma Singleton

import Quickshell
import Quickshell.Io
import QtQml

import "./startup.js" as Script

Singleton {
    id: root
    property alias menus: model

    ListModel {
        id: model
        ListElement {
            action: "lock"
            icon: "lock-icon.svg"
            requireConfirm: false
        }
        ListElement {
            action: "logout"
            icon: "logout-icon.svg"
            requireConfirm: true
        }
        ListElement {
            action: "suspend"
            icon: "pause-icon.svg"
            requireConfirm: true
        }
        ListElement {
            action: "reboot"
            icon: "restart-icon.svg"
            requireConfirm: true
        }
        ListElement {
            action: "shutdown"
            icon: "power-icon.svg"
            requireConfirm: true
        }
    }

    function runScript(action: string) {
        actionProcess.command = Script.script[action];
        actionProcess.running = true;
    }

    Process {
        id: actionProcess
        running: false
    }
}
