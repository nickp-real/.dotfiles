import QtQuick

Item {
    id: root
    implicitHeight: title.implicitHeight
    property alias text: title
    clip: true

    StyledText {
        id: title
    }

    SequentialAnimation {
        id: marquee
        running: title.implicitWidth > root.width
        loops: Animation.Infinite

        PauseAnimation {
            duration: 2000
        }
        NumberAnimation {
            target: title
            property: "x"
            to: root.width - title.implicitWidth
            duration: Math.max(3000, (title.implicitWidth - root.width) * 25)
            easing.type: Easing.Linear
        }
        PauseAnimation {
            duration: 1500
        }
        NumberAnimation {
            target: title
            property: "x"
            to: 0
            duration: 1000
        }
    }

    Connections {
        target: title
        function onTextChanged() {
            title.x = 0;
        }
    }
}
