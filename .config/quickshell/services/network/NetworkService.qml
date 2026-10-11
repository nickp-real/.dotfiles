pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Networking

Singleton {
    function getNetworks(device: NetworkDevice): list<Network> {
        if (!device)
            return [];
        const result = [];

        for (const network of device.networks.values) {
            result.push(network);
        }

        return result;
    }

    function checkConnectivity() {
        if (!Networking.connectivityCheckEnabled)
            return;
        Networking.checkConnectivity();
    }
}
