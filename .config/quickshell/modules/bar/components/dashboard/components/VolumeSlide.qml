import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services

SliderWidget {
    id: root
    Layout.fillWidth: true
    slider.to: 1
    slider.value: VolumeService.volume

    onIconClick: VolumeService.toggleMuted()

    icon.source: VolumeService.icon

    slider.onMoved: function () {
        VolumeService.setVolume(root.slider.value);
        VolumeService.setMuted(false);
    }
}
