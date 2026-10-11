import QtQuick
import QtQuick.Controls
import Quickshell.Networking
import qs.components

import "root:config.js" as Config

Column {
    id: root
    required property WifiNetwork modelData
    property string error: ""
    property alias passwordField: field

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
    }

    onVisibleChanged: {
        root.error = "";
        field.text = "";
        if (visible)
            field.forceActiveFocus();
    }

    TextField {
        id: field
        focus: root.visible
        placeholderText: "Password"
        width: 120
        color: Config.colors.fg
        echoMode: TextInput.Password
    }

    StyledText {
        visible: text !== ""
        color: Config.colors.errorFg
        text: root.error
        font.pixelSize: Config.font.sm
    }
}
