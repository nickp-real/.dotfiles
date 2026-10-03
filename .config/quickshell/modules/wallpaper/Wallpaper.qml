import QtQuick
import Quickshell
import Quickshell.Wayland
import qs.services

Variants {
    model: Quickshell.screens

    PanelWindow {
        id: root
        required property ShellScreen modelData
        screen: modelData
        color: "transparent"
        WlrLayershell.layer: WlrLayer.Bottom
        exclusionMode: ExclusionMode.Ignore

        anchors {
            top: true
            left: true
            right: true
            bottom: true
        }

        DropArea {
            id: dropArea
            anchors.fill: parent

            keys: ["text/uri-list"]
            onEntered: drag => {
                if (!drag.hasUrls)
                    return;
                drag.acceptProposedAction();
            }

            onDropped: drop => {
                if (!drop.hasUrls)
                    return;

                const rawUrl = drop.urls[0].toString();
                const cleanUrl = rawUrl.replace("file://", "");
                WallpaperService.changeWallpaper(root.modelData, cleanUrl, drop.x, root.modelData.height - drop.y);
                drop.acceptProposedAction();
            }
        }
    }
}
