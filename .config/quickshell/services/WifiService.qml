pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Networking

Singleton {
    id: root
    readonly property ObjectModel devices: Networking.devices
    readonly property list<NetworkDevice> deviceList: devices.values
    property bool scanning: false
    property double lastScanMs: 0
    readonly property int scanThreshold: 30
    readonly property bool enabled: Networking.wifiEnabled

    function setWifiEnabled(enabled: bool) {
        if (!Networking.wifiHardwareEnabled)
            return;

        Networking.wifiEnabled = enabled;

        for (const device of root.deviceList) {
            if (device.type !== DeviceType.Wifi)
                continue;
            device.scannerEnabled = enabled;
        }
    }

    function toggleWifiEnabled() {
        setWifiEnabled(!root.enabled);
    }

    Connections {
        target: root.devices
        function onObjectInsertedPost(object, index) {
            if (object.type !== DeviceType.Wifi)
                return;
            object.scannerEnabled = root.enabled;
        }
    }

    function sortWifiNetworks(networks: list<Network>): list<WifiNetwork> {
        let list = [...networks];
        list.sort((a, b) => b.signalStrength - a.signalStrength);
        const knownWifiIndexSet = new Set(list.map((wifi, i) => !wifi.connected && wifi.known ? i : undefined).filter(index => index !== undefined));
        if (knownWifiIndexSet.size > 0) {
            const listWithOutKnown = list.map((wifi, i) => knownWifiIndexSet.has(i) ? undefined : wifi).filter(wifi => wifi !== undefined);
            const knownWifiList = list.filter((_, i) => knownWifiIndexSet.has(i));
            list = [...knownWifiList, ...listWithOutKnown];
        }

        const connectedWifiIndex = list.findIndex(wifi => wifi.connected);
        if (connectedWifiIndex !== -1) {
            const connectedWifi = list[connectedWifiIndex];
            list.splice(connectedWifiIndex, 1);
            list.unshift(connectedWifi);
        }

        return list;
    }

    function needsPassword(network: WifiNetwork): bool {
        return network.security !== WifiSecurityType.Open && network.security !== WifiSecurityType.Owe;
    }

    function isPsk(network: WifiNetwork): bool {
        return network.security === WifiSecurityType.WpaPsk || network.security === WifiSecurityType.Wpa2Psk || network.security === WifiSecurityType.Sae;
    }

    function needsEnterprise(network: WifiNetwork): bool {
        return needsPassword(network) && !isPsk(network);
    }

    function connectToWifi(network: WifiNetwork) {
        if (!needsPassword(network) || network.known)
            network.connect();
    }

    function connectToWifiWithPassword(network: WifiNetwork, password: string) {
        if (needsEnterprise(network))
            return;
        network.connectWithPsk(password);
    }

    function disconnectToWifi(network: WifiNetwork) {
        network.disconnect();
    }

    function forgetWifi(network: WifiNetwork) {
        network.forget();
    }

    function isAutoConnectReady(network: WifiNetwork): bool {
        if (!network.nmSettings.length)
            return false;
        const setting = network.nmSettings[0].read();
        return !!(setting && setting.connection);
    }

    function getAutoConnect(network: WifiNetwork): bool {
        if (!network.nmSettings.length)
            return true;
        const setting = network.nmSettings[0].read();
        if (!setting || !setting.connection)
            return true;
        return setting.connection.autoconnect ?? true;
    }

    function setAutoconnect(network: WifiNetwork, on: bool) {
        if (!network.nmSettings.length)
            return;
        network.nmSettings[0].write({
            "connection": {
                "autoconnect": on
            }
        });
    }

    function rescanWifi(force: bool): bool {
        if (!enabled || scanning)
            return false;
        if (!force && Date.now() - lastScanMs < scanThreshold * 1000)
            return false;
        scanning = true;
        lastScanMs = Date.now();

        for (const device of deviceList) {
            if (device.type !== DeviceType.Wifi)
                continue;
            device.scannerEnabled = false;
            device.scannerEnabled = true;
        }

        rescanTimer.restart();
        return true;
    }

    Timer {
        id: rescanTimer
        interval: 6000
        repeat: false
        onTriggered: root.scanning = false
    }
}
