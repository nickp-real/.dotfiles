import QtQuick
import QtQuick.Controls

import "root:config.js" as Config

Rectangle {
    id: root
    required property bool open
    required property ListView listView

    anchors.fill: parent
    implicitHeight: Config.appLauncher.input.height + Config.appLauncher.padding * 2

    color: Config.colors.accentBg
    radius: Config.radius

    TextField {
        anchors.fill: parent
        leftPadding: Config.appLauncher.padding
        rightPadding: Config.appLauncher.padding
        focus: root.open
        color: Config.colors.mutedFg
        placeholderText: "Search..."
        font.family: Config.font.family
        font.pixelSize: Config.font.base

        background: null

        onTextChanged: AppLauncherEntriesService.filter(text)

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

        Keys.onPressed: event => {
            if (event.modifiers & Qt.ControlModifier && event.key === Qt.Key_W) {
                const allWords = text.split(" ").filter(t => t.trim() !== "");
                allWords.pop();
                text = allWords.join(" ");
                if (allWords.length > 0)
                    text += " ";
                event.accepted = true;
            }
            if (event.key === Qt.Key_Up || (event.modifiers & Qt.ControlModifier && event.key === Qt.Key_P) || event.key === Qt.Key_Backtab) {
                if (root.listView.count === 0)
                    return;

                scrollAndPreview(-1);
                event.accepted = true;
            }

            if (event.key === Qt.Key_Down || (event.modifiers & Qt.ControlModifier && event.key === Qt.Key_N) || event.key === Qt.Key_Tab) {
                if (root.listView.count === 0)
                    return;

                scrollAndPreview(1);
                event.accepted = true;
            }

            if (event.key === Qt.Key_Enter || event.key === Qt.Key_Return) {
                launchSelected();
                event.accepted = true;
            }
        }
    }
}
