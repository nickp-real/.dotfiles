import QtQuick
import QtQuick.Layouts
import qs.components
import qs.services

RowLayout {
    Layout.fillWidth: true

    Text {
        text: VolumeService.source
        color: "white"
    }

    SliderWidget {
        id: root
        Layout.fillWidth: true
        slider.to: 1
        slider.value: VolumeService.volume

        onIconClick: VolumeService.toggleMuted()

        icon.source: {
            if (VolumeService.isMuted)
                return "volume-mute.svg";
            if (VolumeService.volume >= 0.6)
                return "volume-2.svg";
            if (VolumeService.volume >= 0.2)
                return "volume-1.svg";
            return "volume.svg";
        }

        slider.onMoved: function () {
            VolumeService.setVolume(root.slider.value);
            VolumeService.setMuted(false);
        }
    }
}
