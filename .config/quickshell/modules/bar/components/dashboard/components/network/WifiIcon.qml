import Quickshell.Networking
import qs.components
import qs.services

Icon {
    required property WifiNetwork modelData

    function getWifiIcon(network: WifiNetwork): string {
        const isPrivate = WifiService.needsPassword(network);
        const signalStrength = network.signalStrength;

        let signal = "none";
        if (signalStrength > 0.2)
            signal = "low";
        if (signalStrength > 0.4)
            signal = "ok";
        if (signalStrength > 0.6)
            signal = "good";
        if (signalStrength > 0.8)
            signal = "excellent";

        return `network-wireless${isPrivate ? '-secure' : ''}-signal-${signal}`;
    }

    source: getWifiIcon(modelData)
}
