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

            StyledText {
                text: `${Math.ceil(PowerService.percentage * 100)}%`
                font.pixelSize: Config.font.base * 2
                font.features: {
                    "tnum": 1
                }
            }
            StyledText {
                text: PowerService.status
                font.pixelSize: Config.font.base
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
                    style.color: PowerService.currentPowerProfile === modelData ? Config.colors.accentFg : Config.colors.mutedBg

                    implicitHeight: 32

                    contentItem: StyledText {
                        text: PowerService.getPowerProfile(modelData)
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pixelSize: Config.font.base
                        color: PowerService.currentPowerProfile === modelData ? Config.colors.accentBg : Config.colors.mutedFg
                    }
                }
            }
        }
    }
}
