pragma ComponentBehavior: Bound
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.components
import qs.commons

Rectangle {
    id: root
    required property var window
    Layout.fillWidth: true
    height: 20
    color: "transparent"

    RowLayout {
        anchors.fill: parent

        Repeater {
            model: SystemTray.items

            Rectangle {
                id: trayItem
                required property SystemTrayItem modelData
                height: 20
                width: 20
                color: "transparent"

                Icon {
                    id: icon
                    anchors.fill: parent
                    source: trayItem.modelData.icon
                    colorization: false

                    MouseArea {
                        anchors.fill: parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onClicked: mouse => {
                            if (mouse.button == Qt.LeftButton) {
                                trayItem.modelData.activate();
                            } else if (trayItem.modelData.hasMenu) {
                                trayItem.modelData.display(root.window, root.window.width - Theme.bar.leftRightGap - icon.x - root.width, root.window.height + Theme.bar.topBottomGap);
                            }
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillWidth: true
        }
    }
}
