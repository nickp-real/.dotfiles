import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services

RowLayout {
    Layout.fillWidth: true

    SliderWidget {
        id: root
        slider.to: 1
        slider.value: VolumeService.volume

        onIconClick: VolumeService.toggleMuted()

        icon.source: VolumeService.icon

        slider.onMoved: function () {
            VolumeService.setVolume(root.slider.value);
            VolumeService.setMuted(false);
        }
    }

    StyledText {
        text: `${Math.ceil(VolumeService.volume * 100)}%`
        Layout.preferredWidth: 40
        horizontalAlignment: Text.AlignRight
    }
}
