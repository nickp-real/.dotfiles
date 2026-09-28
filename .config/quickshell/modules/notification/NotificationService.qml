pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Singleton {
    id: root

    ListModel {
        id: history
    }

    readonly property alias historyList: history
    readonly property ObjectModel notifications: server.trackedNotifications

    NotificationServer {
        id: server
        actionsSupported: true
        bodySupported: true
        imageSupported: true
        onNotification: n => {
            history.insert(0, {
                summary: n.summary,
                body: n.body,
                appName: n.appName,
                urgency: n.urgency,
                time: Qt.formatDateTime(new Date(), "HH:mm")
            });
            n.tracked = true;
        }
    }

    // function notify(body) {
    //     Quickshell.execDetached(["notify-send", body]);
    // }
}
