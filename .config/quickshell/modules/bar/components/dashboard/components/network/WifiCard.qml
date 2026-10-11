import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Networking
import qs.services.network
import qs.components

import "root:config.js" as Config

Rectangle {
    id: root
    required property WifiNetwork modelData
    readonly property bool connected: modelData.connected
    readonly property bool known: modelData.known
    readonly property bool stateChanging: modelData.stateChanging
    readonly property bool needsPassword: WifiService.needsPassword(modelData)
    readonly property bool needsEnterprise: WifiService.needsEnterprise(modelData)
    readonly property bool isPsk: WifiService.isPsk(modelData)

    property bool isClicked: false

    color: hover.hovered || connected ? Config.colors.mutedBg : "transparent"
    radius: Config.radius
    implicitHeight: isClicked ? !connected && needsPassword ? 96 : 80 : 48

    HoverHandler {
        id: hover
    }

    Item {
        height: 48
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.isClicked = !root.isClicked;
            }
        }
    }

    Item {
        anchors.fill: parent
        anchors.margins: Config.padding

        Row {
            spacing: Config.padding

            WifiIcon {
                modelData: root.modelData
            }

            Column {
                anchors.top: parent.top
                spacing: Config.padding

                Column {
                    StyledText {
                        text: root.modelData.name
                    }
                    // condition text
                    StyledText {
                        visible: root.connected || root.known
                        text: root.connected ? "Connected" : "Known"
                        color: Config.colors.accentFg
                        font.pixelSize: Config.font.sm
                    }
                    StyledText {
                        text: "Work login, use nmcli"
                        visible: root.needsEnterprise && !root.known && !root.connected
                    }
                }

                PasswordField {
                    id: password
                    modelData: root.modelData
                    visible: root.isClicked && !root.known && !root.connected && root.needsPassword && root.isPsk
                    passwordField.onAccepted: connectButton.clicked()
                }
            }
        }

        RowLayout {
            visible: root.isClicked
            spacing: Config.padding

            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            CheckBox {
                id: autoConnectCheckbox
                property bool autoConnect: true
                function refresh() {
                    autoConnect = WifiService.getAutoConnect(root.modelData);
                }

                Component.onCompleted: refresh()
                Connections {
                    target: root
                    function onModelDataChanged() {
                        autoConnectCheckbox.refresh();
                    }
                }

                Connections {
                    target: root.modelData.nmSettings.length !== 0 ? root.modelData.nmSettings[0] : null
                    function onLoaded() {
                        autoConnectCheckbox.refresh();
                    }
                    function onSettingsChanged() {
                        autoConnectCheckbox.refresh();
                    }
                }

                visible: root.modelData.connected || root.modelData.known
                text: "Auto connect"
                checked: autoConnect
                enabled: WifiService.isAutoConnectReady(root.modelData)
                onToggled: WifiService.setAutoconnect(root.modelData, checked)
            }
            Item {
                Layout.fillWidth: true
            }

            Row {
                HoldButton {
                    visible: root.connected || root.known
                    implicitWidth: forgetText.implicitWidth + Config.padding * 2
                    holdColor: Config.colors.errorFg

                    onActivated: WifiService.forgetWifi(root.modelData)

                    contentItem: StyledText {
                        id: forgetText
                        text: "Forget"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Button {
                    id: connectButton
                    implicitWidth: connectText.implicitWidth + Config.padding * 2
                    enabled: !root.stateChanging && (root.connected || !root.needsEnterprise && (root.known || !root.needsPassword || password.passwordField.text.length > 0))

                    onClicked: {
                        if (!enabled)
                            return;

                        if (root.connected) {
                            WifiService.disconnectToWifi(root.modelData);
                            return;
                        }

                        if (!root.known && root.isPsk) {
                            WifiService.connectToWifiWithPassword(root.modelData, password.passwordField.text);
                            return;
                        }

                        WifiService.connectToWifi(root.modelData);
                    }

                    contentItem: StyledText {
                        id: connectText
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: root.stateChanging ? "Connecting..." : root.connected ? "Disconnect" : "Connect"
                        opacity: connectButton.enabled ? 1 : 0.6
                    }
                }
            }
        }
    }
}
