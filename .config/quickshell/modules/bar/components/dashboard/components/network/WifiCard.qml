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
    readonly property int profileCount: WifiService.profileCount(root.modelData)

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
                    Button {
                        id: profile
                        property int index: 0
                        visible: root.isClicked && root.profileCount > 1
                        onClicked: index = (index + 1) % root.profileCount

                        Connections {
                            target: root
                            function onModelDataChanged() {
                                profile.index = 0;
                            }
                        }

                        contentItem: StyledText {
                            text: `Profile: ${WifiService.profileName(root.modelData, profile.index)}`
                        }
                    }
                }

                Column {
                    PasswordField {
                        id: password
                        modelData: root.modelData
                        visible: root.isClicked && !root.connected && root.needsPassword && root.isPsk && (!root.known || passwordError.error !== "")
                        passwordField.onAccepted: connectButton.clicked()
                    }
                    PasswordError {
                        id: passwordError
                        modelData: root.modelData

                        Connections {
                            target: root
                            function onModelDataChanged() {
                                passwordError.reset();
                            }
                            function onIsClickedChanged() {
                                passwordError.reset();
                            }
                        }
                    }
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

            AutoConnect {
                id: autoConnectCheckbox
                modelData: root.modelData
                Connections {
                    target: root
                    function onModelDataChanged() {
                        autoConnectCheckbox.refresh();
                    }
                }
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

                        passwordError.reset();

                        if (root.connected) {
                            WifiService.disconnectToWifi(root.modelData);
                            return;
                        }

                        if (root.profileCount > 1) {
                            WifiService.connectWithProfile(root.modelData, profile.index);
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
