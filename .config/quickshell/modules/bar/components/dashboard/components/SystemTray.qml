pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import qs.components

import "root:config.js" as Config

Rectangle {
    id: root
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
                                trayItem.modelData.display(QsWindow.window, icon.x - Config.padding, icon.y);
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
