import QtQuick
import QtQuick.Controls
import Quickshell

import "root:config.js" as Config

PopupWindow {
    property alias listView: list

    visible: AppLauncherEntriesService.hasResult
    implicitHeight: container.implicitHeight
    implicitWidth: 600
    color: "transparent"
    grabFocus: false

    anchor.margins.top: anchor.window.height + Config.appLauncher.spacing

    Rectangle {
        id: container
        anchors.fill: parent
        radius: Config.radius
        color: Config.colors.accentBg
        implicitHeight: list.implicitHeight + Config.appLauncher.padding * 2

        ListView {
            id: list
            model: AppLauncherEntriesService.filteredEntries

            currentIndex: 0
            anchors.fill: parent
            implicitHeight: Math.min(contentHeight, 480)
            spacing: Config.appLauncher.listView.spacing
            clip: true

            anchors.margins: Config.appLauncher.padding

            onCountChanged: {
                if (list.count === 0 || !AppLauncherEntriesService.hasResult) {
                    list.currentIndex = -1;
                    return;
                }

                list.currentIndex = Math.max(list.currentIndex, 0);

                if (list.currentIndex >= list.count)
                    list.currentIndex = list.count - 1;
            }

            delegate: AppLauncherItem {}

            ScrollBar.vertical: ScrollBar {
                id: sb
                property bool show: sb.active || sb.hovered
                policy: ScrollBar.AsNeeded
                contentItem: Rectangle {
                    opacity: sb.show ? 1 : 0
                    implicitWidth: 8
                    color: Config.colors.accentFg
                    radius: Config.radius

                    Behavior on opacity {
                        enabled: !sb.show
                        NumberAnimation {
                            duration: 500
                            easing.type: Easing.OutCubic
                        }
                    }
                }
            }
        }
    }
}
