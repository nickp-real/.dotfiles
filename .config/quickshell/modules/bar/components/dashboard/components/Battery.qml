import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services

Loader {
    Layout.fillWidth: true
    active: PowerService.isLaptop
    sourceComponent: SliderWidget {
        slider.to: 1
        slider.value: PowerService.percentage
        slider.stepSize: 0
        readonly: true
        icon.source: PowerService.icon
    }
}
