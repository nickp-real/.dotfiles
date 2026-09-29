import QtQuick
import QtQuick.Layouts
import qs.modules.bar.components.dashboard.components

import "root:config.js" as Config

Item {
    id: root

    states: [
        State {
            name: "visible"
            PropertyChanges {
                target: root
                opacity: 1
                visible: true
            }
        },
        State {
            name: "hidden"
            PropertyChanges {
                target: root
                opacity: 0
                visible: false
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

        VolumeSlide {}
        BrightnessSlide {}
        Battery {}
        SystemTray {}

        Item {
            Layout.fillHeight: true
        }
    }
}
