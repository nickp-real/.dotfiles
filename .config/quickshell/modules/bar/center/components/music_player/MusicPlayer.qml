import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Services.Mpris
import qs.modules.bar.components
import qs.components
import qs.services

import "root:config.js" as Config

FadeItem {
    id: root
    implicitWidth: 320
    implicitHeight: 96
    property MprisPlayer player: MusicPlayerService.player

    RowLayout {
        spacing: Config.padding
        width: root.implicitWidth
        height: root.implicitHeight

        Item {
            Layout.preferredWidth: root.implicitHeight
            Layout.preferredHeight: root.implicitHeight

            Image {
                id: image
                anchors.fill: parent
                source: root.player?.trackArtUrl
                visible: false
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                cache: false
                sourceSize.height: root.implicitHeight
                sourceSize.width: sourceSize.height
            }
            Rectangle {
                id: mask
                anchors.fill: image
                radius: Config.radius
                visible: false
                layer.enabled: true
                layer.smooth: true
            }

            MultiEffect {
                anchors.fill: image
                source: image
                maskEnabled: true
                maskSource: mask
            }
        }

        ColumnLayout {
            spacing: Config.padding
            Layout.fillWidth: true

            ColumnLayout {
                Layout.fillWidth: true

                TextMarquee {
                    Layout.fillWidth: true
                    text.text: root.player?.trackTitle
                    text.wrapMode: Text.Wrap
                }
                StyledText {
                    Layout.fillWidth: true
                    text: root.player?.trackArtist
                    wrapMode: Text.NoWrap
                    elide: Text.ElideRight
                    font.pixelSize: Config.font.sm
                }
            }

            Item {
                Layout.fillHeight: true
            }

            StyledSlider {
                id: progress
                enabled: root.player?.canSeek ?? false
                Layout.fillWidth: true
                Layout.preferredHeight: 8

                from: 0
                to: root.player?.length ?? 1
                onPressedChanged: if (!pressed)
                    MusicPlayerService.jumpTo(value)

                FrameAnimation {
                    running: root.player && !progress.pressed
                    onTriggered: progress.value = root.player?.position
                }
            }

            Row {
                spacing: Config.padding
                Layout.alignment: Qt.AlignRight | Qt.AlignBottom

                Button {
                    enabled: root.player?.canGoPrevious
                    onClicked: MusicPlayerService.prev()
                    contentItem: Icon {
                        source: "media-skip-backward"
                    }
                }
                Button {
                    enabled: root.player?.canTogglePlaying
                    onClicked: MusicPlayerService.togglePlayback()
                    contentItem: Icon {
                        source: root.player?.isPlaying ? "media-playback-pause" : "media-playback-start"
                    }
                }
                Button {
                    enabled: root.player?.canGoNext
                    onClicked: MusicPlayerService.next()
                    contentItem: Icon {
                        source: "media-skip-forward"
                    }
                }
            }
        }
    }
}
