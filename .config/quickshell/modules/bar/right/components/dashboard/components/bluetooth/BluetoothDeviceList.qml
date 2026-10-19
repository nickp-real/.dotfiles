import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Bluetooth
import qs.components

import "root:config.js" as Config

ColumnLayout {
    id: root
    required property list<BluetoothDevice> devices
    required property string title
    Layout.fillWidth: true

    visible: devices.length > 0

    StyledText {
        text: root.title
    }
    ListView {
        model: root.devices
        Layout.fillWidth: true
        Layout.preferredHeight: root.devices.length > 0 ? 120 : 0
        clip: true
        spacing: Config.padding / 2

        delegate: BluetoothCard {
            implicitWidth: ListView.view.width
        }

        ScrollBar.vertical: StyledScrollbar {}
    }
}
