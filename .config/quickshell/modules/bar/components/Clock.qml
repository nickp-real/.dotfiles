import QtQuick
import QtQuick.Layouts
import qs.modules.bar.services

import "root:config.js" as Config

RowLayout {
    id: root
    readonly property list<string> timeTextSplit: Time.time.split(" ")

    component ClockText: Text {
        color: Config.colors.fg
        font.bold: true
        font.pixelSize: Config.font.md
        font.family: Config.font.family
    }

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
