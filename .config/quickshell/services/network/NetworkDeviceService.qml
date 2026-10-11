pragma Singleton

import Quickshell
import Quickshell.Networking

Singleton {
    readonly property ObjectModel devices: Networking.devices
    readonly property list<NetworkDevice> deviceList: devices.values
    readonly property int count: deviceList.length
    // shows wifi first
    property int index: Math.max(deviceList.findIndex(device => device.type === DeviceType.Wifi), 0)
    readonly property NetworkDevice current: count > 0 ? deviceList[Math.min(index, count - 1)] : null
    readonly property int deviceType: current ? current.type : -1

    onCountChanged: index = Math.max(0, Math.min(index, count - 1))

    function to(dir: string) {
        if (count < 1)
            return;
        index = (index + count + (dir === "next" ? 1 : -1)) % count;
    }

    function next() {
        to("next");
    }

    function prev() {
        to("prev");
    }
}
