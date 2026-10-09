import QtQuick
import QtQuick.Layouts
import qs.modules.bar.components.dashboard.components
import qs.modules.bar.components.dashboard.components.network
import qs.components

import "root:config.js" as Config

Item {
    id: root

    states: [
        State {
            name: "visible"
            PropertyChanges {
                root.opacity: 1
                root.visible: true
            }
        },
        State {
            name: "hidden"
            PropertyChanges {
                root.opacity: 0
                root.visible: false
            }
        }
    ]
    transitions: [
        Transition {
            from: "hidden"
            to: "visible"
            SequentialAnimation {
                PauseAnimation {
                    duration: 600
                }
                PropertyAction {
                    target: root
                    property: "visible"
                }
                NumberAnimation {
                    target: root
                    property: "opacity"
                    duration: 150
                    easing.type: Easing.OutQuad
                }
            }
        },
        Transition {
            from: "visible"
            to: "hidden"
            SequentialAnimation {
                NumberAnimation {
                    target: root
                    property: "opacity"
                    duration: 150
                    easing.type: Easing.OutQuad
                }
                PropertyAction {
                    target: root
                    property: "visible"
                }
            }
        }
    ]

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 8

        Network {}
        HorizontalDivider {}
        SystemSlider {}
        HorizontalDivider {}
        Battery {}
        HorizontalDivider {}
        SystemTray {}

        Item {
            Layout.fillHeight: true
        }
    }

    component HorizontalDivider: Divider {
        Layout.fillWidth: true
        implicitHeight: 2
    }

    component SystemSlider: ColumnLayout {
        VolumeSlider {}
        BrightnessSlider {}
    }
}
