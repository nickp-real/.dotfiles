import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower
import qs.components

Loader {
    Layout.fillWidth: true
    active: UPower.displayDevice.isLaptopBattery
    sourceComponent: SliderWidget {
        slider.to: 1
        slider.value: UPower.displayDevice.percentage
        slider.stepSize: 0
        readonly: true
        icon.source: UPower.displayDevice.iconName
    }
}
