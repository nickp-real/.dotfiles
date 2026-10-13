import QtQuick
import QtQuick.Layouts
import qs.modules.bar.components.dashboard.components
import qs.components
import qs.services

import "root:config.js" as Config

DashboardSection {
    title: "Bluetooth"
    icon.source: !BluetoothService.enabled ? "bluetooth-disabled" : BluetoothService.connected.length > 0 ? "bluetooth-connected" : "bluetooth-active"
    titleRowContent: Row {
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        spacing: Config.padding

        RescanButton {
            enabled: !BluetoothService.discovering
            onClicked: BluetoothService.setDiscovering(true)
            scanning: BluetoothService.discovering
            visible: BluetoothService.enabled
            anchors.verticalCenter: parent.verticalCenter
        }

        AppSwitch {
            checked: BluetoothService.enabled
            onClicked: BluetoothService.toggleEnabled()
        }
    }

    onVisibleChanged: {
        if (!visible) {
            BluetoothService.setDiscovering(false);
        }
    }

    ColumnLayout {
        Layout.fillWidth: true
        visible: BluetoothService.paired.length > 0 || BluetoothService.available.length > 0
        spacing: BluetoothService.paired.length > 0 && BluetoothService.available.length > 0 ? Config.padding : 0

        BluetoothDeviceList {
            title: "Paired"
            devices: BluetoothService.paired
        }
        BluetoothDeviceList {
            title: "Available"
            devices: BluetoothService.available
        }
    }
}
