import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services

SliderWidget {
    id: root
    Layout.fillWidth: true
    slider.to: BrightnessService.maxBrightness
    slider.value: BrightnessService.brightness

    // onIconClick: VolumeService.toggleMuted()

    icon.source: {
        if (BrightnessService.percent >= 0.6)
            return "brightness-2.svg";
        if (BrightnessService.percent >= 0.2)
            return "brightness-1.svg";
        return "brightness.svg";
    }

    slider.onMoved: function () {
        BrightnessService.setValue(root.slider.value);
    }
}
