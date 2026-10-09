import QtQuick
import qs.modules.bar.services
import qs.components

import "root:config.js" as Config

Item {
    implicitHeight: parent.height
    implicitWidth: 204 + Config.padding * 2

    Row {
        id: root
        readonly property list<string> timeTextSplit: Time.time.split(" ")
        spacing: 4
        anchors.centerIn: parent

        ClockText {
            text: root.timeTextSplit.slice(0, 4).join(" ")
        }

        ClockText {
            text: root.timeTextSplit[4]
            font.features: {
                "tnum": 1
            }
        }

        ClockText {
            text: root.timeTextSplit[5]
        }
    }

    component ClockText: StyledText {
        font.weight: 600
    }
}
