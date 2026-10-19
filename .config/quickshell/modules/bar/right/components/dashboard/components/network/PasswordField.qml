import QtQuick
import QtQuick.Controls
import Quickshell.Networking

import "root:config.js" as Config

Column {
    id: root
    required property WifiNetwork modelData
    property alias passwordField: field

    onVisibleChanged: {
        field.text = "";
        if (visible)
            field.forceActiveFocus();
    }

    TextField {
        id: field
        focus: root.visible
        placeholderText: "Password"
        width: 120
        color: Config.colors.text
        echoMode: TextInput.Password
    }
}
