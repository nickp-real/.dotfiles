import QtQuick
import Quickshell
import Quickshell.Hyprland

PanelWindow {
    id: root
    property bool open: false
    signal close

    default property alias content: content.data

    HyprlandFocusGrab {
        active: root.open
        windows: [root]
        onCleared: {
            root.close();
        }
    }

    Item {
        id: content
        anchors.fill: parent

        Keys.onEscapePressed: event => {
            root.close();
            event.accepted = true;
        }
    }
}
