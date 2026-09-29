import QtQuick
import qs.components
import qs.services

import "root:config.js" as Config

Row {
    id: root
    spacing: Config.padding

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
        },
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
        }
    ]

    Status {
        value: VolumeService.volume * 100
        icon.source: VolumeService.icon
    }
    Status {
        value: PowerService.percentage * 100
        icon.source: PowerService.icon
    }
}
