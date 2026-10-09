import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Networking
import qs.modules.bar.components.dashboard.components

import qs.services
import qs.components

import "root:config.js" as Config

DashboardSection {
    id: root
    title: "Network"
    icon.source: "network-wireless-signal-excellent"
    titleRowContent: Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: Config.padding

        RescanButton {
            visible: WifiService.enabled
            anchors.verticalCenter: parent.verticalCenter
        }

        AppSwitch {
            checked: WifiService.enabled
            onClicked: WifiService.toggleWifiEnabled()
        }
    }

    readonly property bool isWifi: NetworkDeviceService.count > 0 && NetworkDeviceService.deviceType === DeviceType.Wifi

    onVisibleChanged: {
        if (!visible || !WifiService.enabled)
            return;
        NetworkService.checkConnectivity();
        WifiService.rescanWifi(false);
    }

    ColumnLayout {
        Layout.fillWidth: true
        Layout.topMargin: Config.padding
        spacing: Config.padding

        NetworkDevicePager {}

        Item {
            Layout.preferredHeight: 120
            Layout.fillWidth: true

            ListView {
                visible: root.isWifi
                model: root.isWifi ? WifiService.sortWifiNetworks(NetworkService.getNetworks(NetworkDeviceService.current)) : []
                anchors.fill: parent
                spacing: Config.padding / 2
                clip: true

                ScrollBar.vertical: StyledScrollbar {}

                delegate: WifiCard {
                    required property int index
                    implicitWidth: ListView.view.width

                    onIsClickedChanged: {
                        if (!isClicked)
                            return;
                        ListView.view.positionViewAtIndex(index, ListView.Contain);
                    }
                }
            }

            WiredNetworkCard {
                visible: !root.isWifi
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                device: !root.isWifi ? NetworkDeviceService.current as WiredDevice : null
            }
        }
    }
}
