import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services

RowLayout {
    Layout.fillWidth: true

    SliderWidget {
        id: root
        slider.to: BrightnessService.maxBrightness
        slider.value: BrightnessService.brightness

        icon.source: {
            if (BrightnessService.percentage >= 0.6)
                return "brightness-2.svg";
            if (BrightnessService.percentage >= 0.2)
                return "brightness-1.svg";
            return "brightness.svg";
        }

        slider.onMoved: function () {
            BrightnessService.setValue(root.slider.value);
        }
    }

    StyledText {
        text: `${Math.ceil(BrightnessService.percentage * 100)}%`
        Layout.preferredWidth: 40
        horizontalAlignment: Text.AlignRight
    }
}
