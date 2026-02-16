import Quickshell
import QtQuick
import QtQuick.Controls
import qs.commons

Scope {
    id: root

    LazyLoader {
        active: GlobalStates.todoOpen

        FloatingWindow {
            color: contentItem.palette.active.window
            implicitWidth: 200
            implicitHeight: 200

            TextArea {
                anchors.fill: parent
                // text: 'hello'
            }
        }
    }
}
