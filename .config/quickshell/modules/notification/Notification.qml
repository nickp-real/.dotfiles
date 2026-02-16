import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Scope {
    id: root

    Connections {
        target: NotificationServer {
            onNotification: notification => {}
        }
    }

    LazyLoader {
        PopupWindow {
            width: body.width
            height: body.height

            Rectangle {
                id: body
                width: 200
                height: 100
            }
        }
    }
}
