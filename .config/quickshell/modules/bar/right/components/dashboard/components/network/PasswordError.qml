import QtQuick
import Quickshell.Networking
import qs.components

import "root:config.js" as Config

StyledText {
    id: root
    required property WifiNetwork modelData
    property string error: ""

    function reset() {
        error = "";
    }

    Connections {
        target: root.modelData
        function onConnectionFailed(reason: ConnectionFailReason) {
            switch (reason) {
            case ConnectionFailReason.NoSecrets:
                root.error = root.modelData.known ? "Wrong password" : "Need password";
                break;
            case ConnectionFailReason.WifiAuthTimeout:
                root.error = "Took too long, try again";
                break;
            case ConnectionFailReason.WifiNetworkLost:
                root.error = "Network gone";
                break;
            default:
                root.error = "Connection failed";
            }
        }
        function onConnectedChanged() {
            if (root.modelData.connected)
                root.reset();
        }
    }

    visible: text !== ""
    color: Config.colors.errorFg
    text: root.error
    font.pixelSize: Config.font.sm
}
