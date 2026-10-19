import QtQuick
import QtQuick.Layouts

import qs.components
import qs.services.network

import "root:config.js" as Config

ColumnLayout {
    id: root
    property bool expanded: false
    readonly property int count: VPNService.vpnList?.length ?? 0
    visible: count > 0

    RowLayout {
        Icon {
            source: "network-vpn"
        }
        StyledText {
            text: `VPN (${root.count})`
        }
        Item {
            Layout.fillWidth: true
        }
        Button {
            enabled: root.count > 0
            visible: root.count > 0
            onClicked: root.expanded = !root.expanded

            contentItem: Icon {
                source: root.expanded ? "go-down" : "go-next"
            }
        }
    }

    Repeater {
        visible: root.expanded || VPNService.anyActive
        model: VPNService.vpnList
        Row {
            id: vpn
            required property var modelData

            StyledText {
                text: vpn.modelData.name
            }
            Button {
                id: connectButton
                readonly property bool connected: vpn.modelData.active

                implicitWidth: text.implicitWidth + Config.padding * 2

                onClicked: connectButton.connected ? VPNService.disconnect(vpn.modelData.uuid) : VPNService.connect(vpn.modelData.uuid)

                contentItem: StyledText {
                    id: text
                    text: !connectButton.connected ? "Connect" : "Disconnect"
                }
            }
        }
    }
}
