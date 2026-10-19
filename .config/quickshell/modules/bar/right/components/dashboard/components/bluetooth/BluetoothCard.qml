import QtQuick
import Quickshell.Bluetooth
import qs.services
import qs.components

import "root:config.js" as Config

Rectangle {
    id: root
    required property BluetoothDevice modelData
    readonly property bool pairing: modelData.pairing
    readonly property bool connected: modelData.connected
    readonly property bool paired: modelData.paired

    property bool isClicked: false

    implicitHeight: isClicked ? 96 : 64
    color: hover.hovered || connected ? Config.colors.hoverBg : "transparent"
    radius: Config.radius

    HoverHandler {
        id: hover
    }

    Item {
        height: 64
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.isClicked = !root.isClicked;
            }
        }
    }

    Item {
        anchors.fill: parent
        anchors.margins: Config.padding

        Row {
            spacing: Config.padding
            Icon {
                source: root.modelData.icon
            }

            Column {
                StyledText {
                    text: {
                        const n = root.modelData.name || root.modelData.deviceName || root.modelData.address;
                        return n.length > 24 ? `${n.slice(0, 24)}…` : n;
                    }
                }
                StyledText {
                    text: root.modelData.address && (root.modelData.name || root.modelData.deviceName) ? root.modelData.address : ""
                    font.pixelSize: Config.font.sm
                }
                StyledText {
                    text: root.modelData.paired ? "Paired" : root.modelData.pairing ? "Pairing..." : ""
                    color: Config.colors.accent
                }
            }
        }

        Row {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            visible: root.isClicked
            spacing: Config.padding / 2

            HoldButton {
                visible: root.paired
                implicitWidth: forgetText.implicitWidth + Config.padding
                onActivated: BluetoothService.forget(root.modelData)

                contentItem: StyledText {
                    id: forgetText
                    text: "Forget"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Button {
                enabled: !root.pairing
                onClicked: BluetoothService.toggleConnection(root.modelData)
                implicitWidth: connectText.implicitWidth + Config.padding

                contentItem: StyledText {
                    id: connectText
                    text: root.connected ? "Disconnect" : "Connect"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
}
