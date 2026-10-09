import QtQuick
import qs.components
import qs.services

import "root:config.js" as Config

Button {
    enabled: !WifiService.scanning
    onClicked: WifiService.rescanWifi(true)

    implicitWidth: icon.width + Config.padding
    implicitHeight: implicitWidth

    Icon {
        id: icon
        source: "refresh.svg"
        anchors.centerIn: parent

        RotationAnimator on rotation {
            from: 0
            to: 360
            duration: 900
            loops: Animation.Infinite
            running: WifiService.scanning
            onStopped: icon.rotation = 0
        }
    }
}
