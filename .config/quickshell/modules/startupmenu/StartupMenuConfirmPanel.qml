import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland

import "root:config.js" as Config

PanelWindow {
    id: root

    property bool open: false
    property var handleOnConfirmAction

    focusable: open
    visible: open

    implicitHeight: 200
    implicitWidth: 400
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore

    HyprlandFocusGrab {
        active: root.open
        windows: [root]
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
            if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
                if (currentFocusAction === "confirm")
                    root.handleOnConfirmAction(true);
                else
                    root.handleOnConfirmAction(false);
                event.accepted = true;
            }
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
                    icon: "x.svg"
                    onAction: root.handleOnConfirmAction(false)
                    isFocused: confirmPanel.currentFocusAction === "cancel"
                    onHoverEntered: confirmPanel.currentFocusAction = "cancel"
                    onHoverExited: {
                        confirmPanel.currentFocusAction = "";
                        confirmPanel.forceActiveFocus();
                    }
                }
                StartupMenuButton {
                    icon: "check.svg"
                    onAction: root.handleOnConfirmAction(true)
                    isFocused: confirmPanel.currentFocusAction === "confirm"
                    onHoverEntered: confirmPanel.currentFocusAction = "confirm"
                    onHoverExited: {
                        confirmPanel.currentFocusAction = "";
                        confirmPanel.forceActiveFocus();
                    }
                }
            }
        }
    }
}
