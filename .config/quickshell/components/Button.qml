import QtQuick
import QtQuick.Controls

import "root:config.js" as Config

AbstractButton {
    id: root
    property bool highlighted: false
    property alias style: styleButton

    implicitWidth: Config.button.width
    implicitHeight: Config.button.height

    background: ButtonBase {
        id: styleButton
    }
}
