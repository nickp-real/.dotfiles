import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

import "root:config.js" as Config

PanelWindow {
    id: root
    property bool open: false
    signal actionClick(action: string, requireConfirm: bool)
    signal requestClose

    implicitHeight: startupPanel.implicitHeight
    implicitWidth: startupPanel.implicitWidth
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore

    focusable: open
    visible: open

    HyprlandFocusGrab {
        active: root.open
        windows: [root]
        onCleared: {
            root.requestClose();
        }
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
        running: root.visible
        stdout: StdioCollector {
            onStreamFinished: uptime.text = `Uptime: ${this.text}`
        }
    }

    Rectangle {
        id: startupPanel
        property int currentFocusActionIndex: -1
        property ListModel menus: StartupMenuService.menus
        focus: true

        anchors.fill: parent
        radius: Config.radius
        color: Config.colors.bg

        implicitWidth: panel.width + Config.padding * 4
        implicitHeight: panel.height + Config.padding * 4

        Keys.onPressed: event => {
            if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
                if (currentFocusActionIndex < 0)
                    return;
                const current = menus.get(currentFocusActionIndex);
                root.actionClick(current.action, current.requireConfirm);
                event.accepted = true;
            }
            if (event.key === Qt.Key_Escape) {
                root.requestClose();
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
                        font.family: Config.font.family
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
                        font.family: Config.font.family
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
                        model: startupPanel.menus
                        delegate: StartupMenuButton {
                            required property var model
                            required property int index
                            icon: model.icon
                            onAction: root.actionClick(model.action, model.requireConfirm)
                            isFocused: startupPanel.currentFocusActionIndex === index
                            onHoverEntered: startupPanel.currentFocusActionIndex = index
                            onHoverExited: {
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
