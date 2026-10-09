import QtQuick
import QtQuick.Layouts
import qs.services
import qs.components

import "root:config.js" as Config

RowLayout {
    visible: NetworkDeviceService.count > 0

    Layout.fillWidth: true
    Layout.preferredHeight: 24

    StyledText {
        id: text
        text: NetworkDeviceService.current?.name ? `Device: ${NetworkDeviceService.current.name}` : ""
    }

    Item {
        Layout.fillWidth: true
    }

    Row {
        spacing: Config.padding

        Button {
            onClicked: NetworkDeviceService.prev()
            Icon {
                source: "go-previous"
                anchors.centerIn: parent
            }
        }

        Button {
            onClicked: NetworkDeviceService.next()
            Icon {
                source: "go-next"
                anchors.centerIn: parent
            }
        }
    }
}
