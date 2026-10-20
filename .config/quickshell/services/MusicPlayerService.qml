pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Singleton {
    id: root
    property var players: Mpris.players.values
    readonly property var browserIds: ["firefox", "zen", "chromium", "chrome", "brave", "vivaldi", "opera", "microsoft-edge", "msedge"]

    readonly property var candidates: players.filter(p => !isBrowser(p))
    readonly property MprisPlayer player: candidates.find(p => p.isPlaying && p.lengthSupported) ?? players.find(p => p.isPlaying) ?? players.find(p => p.lengthSupported) ?? candidates[0] ?? null

    FrameAnimation {
        running: root.player?.isPlaying
        onTriggered: root.player?.positionChanged()
    }

    function isBrowser(p) {
        if (!p)
            return false;
        const tokens = `${p.desktopEntry} ${p.identity} ${p.dbusName}`.toLowerCase().split(/[^a-z0-9]+/);
        return browserIds.some(id => tokens.includes(id));
    }

    function jumpTo(time: real) {
        if (!player?.canSeek)
            return;
        player.position = time;
    }

    function next() {
        if (!player?.canGoNext)
            return;
        player?.next();
    }

    function prev() {
        if (!player?.canGoPrevious)
            return;
        player?.previous();
    }

    function togglePlayback() {
        if (!player?.canTogglePlaying)
            return;
        if (player?.isPlaying)
            player?.pause();
        else
            player?.play();
    }
}
