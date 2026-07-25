import Quickshell
import Quickshell.Services.Notifications
import QtQuick

import "root:config.js" as Config

Scope {
    id: root
    ListModel {
        id: history
    }

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

    NotificationHistoryPanel {
        history: history
    }

    NotificationList {
        notifications: server.trackedNotifications
    }
}
