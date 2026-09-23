import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "root:config.js" as Config

Item {
    Layout.fillWidth: true
    Layout.bottomMargin: Config.appLauncher.padding
    Layout.leftMargin: Config.appLauncher.padding
    Layout.rightMargin: Config.appLauncher.padding
    visible: AppLauncherEntriesService.filteredEntries.count > 0
    implicitHeight: list.implicitHeight

    property alias listView: list

    ListView {
        id: list
        model: AppLauncherEntriesService.filteredEntries
        currentIndex: 0
        anchors.fill: parent
        implicitHeight: Math.min(contentHeight, 480)
        spacing: Config.appLauncher.listView.spacing
        clip: true

        onCountChanged: {
            if (list.count === 0) {
                list.currentIndex = -1;
                return;
            }
            list.currentIndex = Math.max(0, list.currentIndex);

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
