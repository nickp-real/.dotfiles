import QtQuick
import QtQuick.Controls

import "root:config.js" as Config

DelayButton {
    id: root
    delay: 2000

    property color holdColor: Config.colors.accentFg
    property alias style: buttonStyle

    onReleased: if (checked)
        checked = false

    background: Item {
        ButtonBase {
            id: buttonStyle
            anchors.fill: parent
        }
        Item {
            anchors.fill: parent
            clip: true
            ButtonBase {
                width: parent.width * root.progress
                height: parent.height
                color: root.holdColor
            }
        }
    }

    implicitWidth: Config.button.width
    implicitHeight: Config.button.height
}
