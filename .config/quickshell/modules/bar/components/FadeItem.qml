import QtQuick

Item {
    id: root
    required property bool shown
    state: shown ? "visible" : "hidden"

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
}
