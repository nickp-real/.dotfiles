import QtQuick
import QtQuick.Layouts
import Quickshell
import qs.components

import "root:config.js" as Config

PopupPanelWindow {
    id: root

    signal confirmAction(confirm: bool)
    onClose: root.confirmAction(false)

    focusable: open
    visible: open

    implicitHeight: 200
    implicitWidth: 400
    color: "transparent"
    exclusionMode: ExclusionMode.Ignore

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
                    root.confirmAction(true);
                else
                    root.confirmAction(false);
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
            anchors.centerIn: parent
            spacing: Config.startupMenu.spacing

            Rectangle {
                Layout.alignment: Qt.AlignHCenter
                implicitHeight: 40
                implicitWidth: text.width + Config.padding
                color: Config.colors.red

                StyledText {
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
                    iconSource: "x.svg"
                    onPressed: root.confirmAction(false)
                    highlighted: confirmPanel.currentFocusAction === "cancel"
                    onHoveredChanged: {
                        if (hovered)
                            confirmPanel.currentFocusAction = "cancel";
                        else {
                            confirmPanel.currentFocusAction = "";
                            confirmPanel.forceActiveFocus();
                        }
                    }
                }
                StartupMenuButton {
                    iconSource: "check.svg"
                    onPressed: root.confirmAction(true)
                    highlighted: confirmPanel.currentFocusAction === "confirm"
                    onHoveredChanged: {
                        if (hovered)
                            confirmPanel.currentFocusAction = "confirm";
                        else {
                            confirmPanel.currentFocusAction = "";
                            confirmPanel.forceActiveFocus();
                        }
                    }
                }
            }
        }
    }
}
