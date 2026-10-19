import QtQuick
import qs.components
import qs.services
import qs.modules.bar.components

import "root:config.js" as Config

FadeItem {
    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    Row {
        id: content
        spacing: Config.padding

        Status {
            value: Math.ceil(VolumeService.volume * 100)
            icon.source: VolumeService.icon
        }
        Loader {
            active: PowerService.isLaptop
            sourceComponent: Row {
                spacing: Config.padding
                Divider {
                    implicitHeight: parent.implicitHeight
                    implicitWidth: 2
                }
                Status {
                    value: Math.ceil(PowerService.percentage * 100)
                    icon.source: PowerService.icon
                }
            }
        }
    }
}
