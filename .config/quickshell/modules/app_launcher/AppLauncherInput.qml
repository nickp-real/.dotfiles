import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "root:config.js" as Config

Item {
    id: root
    required property bool open
    required property ListView listView

    implicitHeight: Config.appLauncher.input.height
    Layout.fillWidth: true
    Layout.topMargin: Config.appLauncher.padding
    Layout.bottomMargin: listView.count > 0 ? 0 : Config.appLauncher.padding
    Layout.leftMargin: Config.appLauncher.padding
    Layout.rightMargin: Config.appLauncher.padding

    function scrollAndPreview(value: int) {
        root.listView.currentIndex = (root.listView.currentIndex + value + root.listView.count) % root.listView.count;
        root.listView.positionViewAtIndex(root.listView.currentIndex, ListView.Contain);
    }

    function launchSelected() {
        if (root.listView.count === 0 || root.listView.currentIndex < 0)
            return;

        const row = AppLauncherEntriesService.filteredEntries.get(root.listView.currentIndex);
        AppLauncherEntriesService.launch(row.entryId);
    }

    TextField {
        anchors.fill: parent
        focus: root.open
        onTextChanged: AppLauncherEntriesService.filter(text)
        color: "white"
        placeholderText: "Search..."
        font.family: Config.font.family
        font.pixelSize: Config.font.base
        background: null

        Keys.onPressed: event => {
            if (event.key === Qt.Key_Up || (event.modifiers & Qt.ControlModifier && event.key === Qt.Key_P) || event.key === Qt.Key_Backtab) {
                if (root.listView.count === 0)
                    return;

                root.scrollAndPreview(-1);
                event.accepted = true;
            }

            if (event.key === Qt.Key_Down || (event.modifiers & Qt.ControlModifier && event.key === Qt.Key_N) || event.key === Qt.Key_Tab) {
                if (root.listView.count === 0)
                    return;

                root.scrollAndPreview(1);
                event.accepted = true;
            }

            if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
                root.launchSelected();
                event.accepted = true;
            }
        }
    }
}
