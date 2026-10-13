pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Bluetooth

Singleton {
    id: root
    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter
    readonly property bool enabled: adapter?.enabled ?? false
    readonly property bool discovering: adapter?.discovering ?? false
    readonly property list<BluetoothDevice> devices: adapter?.devices.values ?? []
    readonly property list<BluetoothDevice> connected: devices.filter(d => d.connected)
    readonly property list<BluetoothDevice> paired: devices.filter(d => d.paired)
    readonly property list<BluetoothDevice> available: devices.filter(d => !d.paired && !d.pairing)

    function toggleEnabled() {
        if (!adapter)
            return;
        adapter.enabled = !adapter.enabled;
    }

    function setDiscovering(on: bool) {
        discoveringTimer.stop();
        if (!adapter)
            return;
        adapter.discovering = on;

        if (on)
            discoveringTimer.restart();
    }

    Timer {
        id: discoveringTimer
        interval: 10000
        repeat: false
        onTriggered: root.setDiscovering(false)
    }

    function toggleConnection(device: BluetoothDevice) {
        if (device.connected)
            device.disconnect();
        else if (!device.paired)
            device.pair();
        else
            device.connect();
    }

    function forget(device: BluetoothDevice) {
        device.forget();
    }
}
