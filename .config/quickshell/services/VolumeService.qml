pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
    id: root
    property bool isVolumeChange: false
    property PwNode sink: Pipewire.defaultAudioSink
    property PwNode source: Pipewire.defaultAudioSource
    property real volume: sink?.audio.volume ?? 0
    property bool isMuted: sink?.audio.muted ?? false
    property string icon: {
        if (VolumeService.isMuted)
            return "volume-mute.svg";
        if (VolumeService.volume >= 0.6)
            return "volume-2.svg";
        if (VolumeService.volume >= 0.2)
            return "volume-1.svg";
        return "volume.svg";
    }

    PwObjectTracker {
        objects: [root.source, root.sink]
    }

    Connections {
        target: root.sink?.audio ?? null

        function onVolumeChanged() {
            root.isVolumeChange = true;
        }
    }

    function setVolume(volume) {
        root.sink.audio.volume = volume;
    }

    function setMuted(isMuted) {
        root.sink.audio.muted = isMuted;
    }

    function toggleMuted() {
        setMuted(!root.sink.audio.muted);
    }
}
