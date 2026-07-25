pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

import "./startup.js" as Script

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

    onOpenChanged: {
        if (root.open)
            startupPanel.forceActiveFocus();
        if (!root.open)
            startupPanel.currentFocusActionIndex = -1;

        if (confirmWindow.isOpen)
            confirmPanel.forceActiveFocus();
        if (!confirmWindow.isOpen)
            confirmPanel.currentFocusAction = "confirm";
    }

    function handleOnActionClick(action: string, requireConfirm: bool) {
        root.open = false;
        if (!requireConfirm)
            runScript(action);

        if (requireConfirm)
            root.currentAction = action;
    }

    function handleOnConfirmAction(confirm: bool) {
        if (confirm)
            runScript(root.currentAction);

        root.currentAction = "";
    }

    function runScript(action: string) {
        actionProcess.command = Script.script[action];
        actionProcess.running = true;
    }

    Process {
        id: actionProcess
        running: false
    }

    Process {
        command: ["hostnamectl", "hostname"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: hostname.text = this.text
        }
    }

    Process {
        command: ["sh", "-c", "uptime -p | sed -e 's/up //g'"]
        running: root.open
        stdout: StdioCollector {
            onStreamFinished: uptime.text = `Uptime: ${this.text}`
        }
    }

    PanelWindow {
        id: startupWindow

        ListModel {
            id: menus
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

        implicitHeight: startupPanel.implicitHeight
        implicitWidth: startupPanel.implicitWidth
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore

        focusable: root.open
        visible: root.open

        HyprlandFocusGrab {
            active: root.open
            windows: [startupWindow]
            onCleared: {
                root.open = false;
            }
        }

        Rectangle {
            id: startupPanel
            property int currentFocusActionIndex: -1
            focus: true

            anchors.fill: parent
            radius: Config.radius
            color: Config.colors.bg

            implicitWidth: panel.width + Config.padding * 4
            implicitHeight: panel.height + Config.padding * 4

            Keys.onPressed: event => {
                if (event.key === Qt.Key_Escape) {
                    root.open = false;
                    event.accepted = true;
                }
                if (event.key === Qt.Key_Tab) {
                    currentFocusActionIndex = (currentFocusActionIndex + 1) % menus.count;
                    event.accepted = true;
                }
                if (event.key === Qt.Key_Backtab) {
                    if (currentFocusActionIndex <= 0)
                        currentFocusActionIndex = menus.count - 1;
                    else
                        currentFocusActionIndex -= 1;
                    event.accepted = true;
                }
            }

            ColumnLayout {
                id: panel
                spacing: Config.startupMenu.spacing
                anchors {
                    verticalCenter: parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }

                RowLayout {
                    spacing: 16
                    Layout.alignment: Qt.AlignHCenter

                    Rectangle {
                        color: Config.colors.red
                        implicitHeight: 40
                        implicitWidth: hostname.width + Config.padding * 2

                        Text {
                            id: hostname
                            anchors {
                                verticalCenter: parent.verticalCenter
                                horizontalCenter: parent.horizontalCenter
                            }
                            font.pixelSize: Config.font.base
                            color: Config.colors.bg
                        }
                    }
                    Rectangle {
                        color: Config.colors.green
                        implicitHeight: 40
                        implicitWidth: childrenRect.width + Config.padding * 2

                        Text {
                            id: uptime
                            anchors {
                                verticalCenter: parent.verticalCenter
                                horizontalCenter: parent.horizontalCenter
                            }
                            font.pixelSize: Config.font.base
                            color: Config.colors.bg
                        }
                    }
                }

                ColumnLayout {
                    Layout.alignment: Qt.AlignHCenter
                    spacing: Config.startupMenu.button.spacing

                    RowLayout {
                        spacing: Config.startupMenu.button.spacing

                        Repeater {
                            model: menus
                            delegate: StartupMenuButton {
                                required property var model
                                required property int index
                                onAction: root.handleOnActionClick(model.action, model.requireConfirm)
                                icon: model.icon
                                focus: startupPanel.currentFocusActionIndex === index
                                hover.onHoveredChanged: {
                                    if (hover.hovered) {
                                        startupPanel.currentFocusActionIndex = index;
                                    } else {
                                        startupPanel.currentFocusActionIndex = -1;
                                        startupPanel.forceActiveFocus();
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    //  confirm popup
    PanelWindow {
        id: confirmWindow
        readonly property bool isOpen: root.currentAction !== ""
        focusable: confirmWindow.isOpen
        visible: confirmWindow.isOpen

        implicitHeight: 200
        implicitWidth: 400
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore

        HyprlandFocusGrab {
            active: confirmWindow.isOpen
            windows: [confirmWindow]
            onCleared: {
                root.handleOnConfirmAction(false);
            }
        }

        Rectangle {
            id: confirmPanel
            property string currentFocusAction: "confirm"

            anchors.fill: parent
            radius: Config.radius
            color: Config.colors.bg
            focus: true

            Keys.onPressed: event => {
                if (event.key === Qt.Key_Escape) {
                    root.handleOnConfirmAction(false);
                    event.accepted = true;
                }
                if (event.key === Qt.Key_Tab) {
                    currentFocusAction = currentFocusAction === "cancel" ? "confirm" : "cancel";
                    event.accepted = true;
                }
                if (event.key === Qt.Key_Backtab) {
                    currentFocusAction = currentFocusAction === "confirm" ? "cancel" : "confirm";
                    event.accepted = true;
                }
            }

            ColumnLayout {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
                spacing: Config.startupMenu.spacing

                Rectangle {
                    Layout.alignment: Qt.AlignHCenter
                    implicitHeight: 40
                    implicitWidth: text.width + Config.padding
                    color: Config.colors.red

                    Text {
                        id: text
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        text: "Are you sure?"
                        font.pixelSize: Config.font.base
                        color: Config.colors.bg
                    }
                }

                RowLayout {
                    spacing: Config.startupMenu.button.spacing

                    StartupMenuButton {
                        onAction: root.handleOnConfirmAction(false)
                        icon: "x.svg"
                        focus: confirmPanel.currentFocusAction === "cancel"
                        hover.onHoveredChanged: {
                            if (hover.hovered) {
                                confirmPanel.currentFocusAction = "cancel";
                            } else {
                                confirmPanel.currentFocusAction = "";
                                confirmPanel.forceActiveFocus();
                            }
                        }
                    }
                    StartupMenuButton {
                        onAction: root.handleOnConfirmAction(true)
                        icon: "check.svg"
                        focus: confirmPanel.currentFocusAction === "confirm"
                        hover.onHoveredChanged: {
                            if (hover.hovered) {
                                confirmPanel.currentFocusAction = "confirm";
                            } else {
                                confirmPanel.currentFocusAction = "";
                                confirmPanel.forceActiveFocus();
                            }
                        }
                    }
                }
            }
        }
    }
}
