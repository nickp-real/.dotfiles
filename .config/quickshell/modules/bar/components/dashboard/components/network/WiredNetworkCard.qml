import QtQuick
import Quickshell.Networking
import qs.components

import "root:config.js" as Config

Rectangle {
    id: root
    property WiredDevice device: null
    readonly property bool connected: device?.connected ?? false
    readonly property bool hasLink: device?.hasLink ?? false

    color: hover.hovered || connected ? Config.colors.mutedBg : "transparent"
    implicitHeight: 56
    radius: Config.radius

    HoverHandler {
        id: hover
    }

    Item {
        anchors.fill: parent
        anchors.margins: Config.padding

        Row {
            spacing: Config.padding

            Icon {
                source: !root.device || !root.hasLink ? "network-wired-disconnected" : root.connected ? "network-wired-activated" : "network-wired"
            }

            Column {
                StyledText {
                    text: !root.device || !root.hasLink ? "Wired" : root.device.network?.name ?? root.device.name
                }
                StyledText {
                    text: !root.device || !root.hasLink ? "Cable unplugged" : root.connected ? `${root.device.name} • ${root.device.linkSpeed} Mb/s` : `Link • ${root.device.linkSpeed} Mb/s`
                    color: Config.colors.accentFg
                    font.pixelSize: Config.font.sm
                }
            }
        }

        Button {
            anchors {
                right: parent.right
                bottom: parent.bottom
            }
            enabled: root?.hasLink ?? false
            implicitWidth: text.implicitWidth + Config.padding * 2

            onClicked: {
                if (!root.device || !root.hasLink)
                    return;
                if (root.connected)
                    root.device.disconnect();
                else
                    root.device.network?.connect();
            }

            contentItem: StyledText {
                id: text
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: root.connected ? "Disconnect" : "Connect"
                opacity: enabled ? 1 : 0.6
            }
        }
    }
}
