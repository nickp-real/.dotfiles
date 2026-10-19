import QtQuick
import QtQuick.Layouts

import "root:config.js" as Config

Rectangle {
    id: root
    default property alias content: row.data

    color: Config.colors.surface
    implicitHeight: Config.bar.height
    implicitWidth: row.implicitWidth + Config.padding * 2

    transitions: Transition {
        from: "*"
        to: "*"
        SequentialAnimation {
            PauseAnimation {
                duration: 150
            }
            NumberAnimation {
                target: root
                duration: 150
                easing: Easing.OutQuad
                properties: "implicitWidth,implicitHeight"
            }
        }
    }

    RowLayout {
        id: row
        spacing: Config.padding
        anchors.fill: parent
        anchors.margins: Config.padding
    }
}
