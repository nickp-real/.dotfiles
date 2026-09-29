import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services

import "root:config.js" as Config

Loader {
    active: PowerService.isLaptop
    Layout.fillWidth: true
    sourceComponent: DashboardSection {
        title: "Battery"
        icon.source: PowerService.icon

        RowLayout {
            spacing: 8

            Text {
                text: `${PowerService.percentage * 100}%`
                font.pixelSize: Config.font.base * 2
                font.family: Config.font.family
                color: Config.colors.fg
                font.features: {
                    "tnum": 1
                }
            }
            Text {
                text: PowerService.status
                font.family: Config.font.family
                font.pixelSize: Config.font.base
                color: Config.colors.fg
            }
        }

        RowLayout {
            spacing: 8
            Repeater {
                model: PowerService.powerProfiles
                delegate: Button {
                    required property int modelData

                    Layout.fillWidth: true
                    onClicked: PowerService.setPowerProfile(modelData)
                    color: PowerService.currentPowerProfile === modelData ? Config.colors.accentFg : Config.colors.mutedBg

                    implicitHeight: 32

                    Text {
                        text: PowerService.getPowerProfile(modelData)
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.family: Config.font.family
                        font.pixelSize: Config.font.base
                        color: PowerService.currentPowerProfile === modelData ? Config.colors.accentBg : Config.colors.mutedFg
                    }
                }
            }
        }
    }
}
