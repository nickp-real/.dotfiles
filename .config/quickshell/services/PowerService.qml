pragma Singleton

import Quickshell
import Quickshell.Services.UPower

Singleton {
    id: root
    property UPowerDevice device: UPower.displayDevice
    property bool isLaptop: device.isLaptopBattery
    property double percentage: device.percentage
    property string icon: device.iconName
}
