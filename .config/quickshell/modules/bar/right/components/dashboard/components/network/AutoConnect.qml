pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Controls
import Quickshell.Networking
import qs.services.network

CheckBox {
    id: root
    required property WifiNetwork modelData
    property bool autoConnect: true

    function refresh() {
        autoConnect = WifiService.getAutoConnect(root.modelData);
    }

    Component.onCompleted: refresh()

    Instantiator {
        model: root.modelData.nmSettings
        Connections {
            required property var modelData
            target: modelData
            function onLoaded() {
                root.refresh();
            }
            function onSettingsChanged() {
                root.refresh();
            }
        }
    }

    visible: root.modelData.connected || root.modelData.known
    text: "Auto connect"
    checked: autoConnect
    enabled: WifiService.isAutoConnectReady(root.modelData)
    onToggled: WifiService.setAutoconnect(root.modelData, checked)
}
