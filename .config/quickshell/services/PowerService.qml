pragma Singleton

import Quickshell
import Quickshell.Services.UPower
import qs.utils

Singleton {
    id: root
    readonly property UPowerDevice device: UPower.displayDevice
    readonly property bool isLaptop: device.isLaptopBattery
    readonly property double percentage: device.percentage
    readonly property string icon: device.iconName
    readonly property string status: UPowerDeviceState.toString(device.state)

    readonly property int currentPowerProfile: PowerProfiles.profile

    readonly property list<int> powerProfiles: {
        const list = [PowerProfile.PowerSaver, PowerProfile.Balanced];
        if (PowerProfiles.hasPerformanceProfile)
            list.push(PowerProfile.Performance);
        return list;
    }

    function getPowerProfile(profile: int): string {
        return StringUtils.startCase(PowerProfile.toString(profile));
    }

    function setPowerProfile(profile: int) {
        PowerProfiles.profile = profile;
    }
}
