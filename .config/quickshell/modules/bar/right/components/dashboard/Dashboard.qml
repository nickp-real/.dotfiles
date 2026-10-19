import QtQuick
import QtQuick.Layouts
import qs.modules.bar.right.components.dashboard.components
import qs.modules.bar.right.components.dashboard.components.network
import qs.modules.bar.right.components.dashboard.components.bluetooth
import qs.modules.bar.components
import qs.components

import "root:config.js" as Config

FadeItem {
    id: root

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 8
        spacing: 8

        Network {}
        HorizontalDivider {}
        Bluetooth {}
        HorizontalDivider {}
        SystemSlider {}
        HorizontalDivider {}
        Battery {}
        HorizontalDivider {}
        SystemTray {}

        Item {
            Layout.fillHeight: true
        }
    }

    component HorizontalDivider: Divider {
        Layout.fillWidth: true
        implicitHeight: 2
    }

    component SystemSlider: ColumnLayout {
        VolumeSlider {}
        BrightnessSlider {}
    }
}
