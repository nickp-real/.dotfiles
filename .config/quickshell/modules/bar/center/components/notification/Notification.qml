import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications
import qs.modules.bar.components
import qs.components
import qs.services

import "root:config.js" as Config

FadeItem {
    id: root
    readonly property ListModel history: NotificationService.historyList
    implicitWidth: 480
    implicitHeight: 400

    ColumnLayout {
        anchors.fill: parent
        spacing: Config.padding

        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop

            StyledText {
                Layout.fillWidth: true
                text: "Notifications"
                color: Config.colors.infoFg
                font.pixelSize: Config.font.base + 2
                font.weight: 600
            }

            StyledText {
                text: "Clear all"
                visible: root.history.count > 0
                color: Config.colors.errorFg
                font.pixelSize: Config.font.base - 2
                MouseArea {
                    anchors.fill: parent
                    onClicked: root.history.clear()
                }
            }
        }

        ListView {
            id: historyListView
            visible: root.history.count > 0
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: contentHeight
            clip: true
            spacing: Config.padding
            model: root.history

            delegate: Rectangle {
                id: card
                required property string summary
                required property string body
                required property string appName
                required property NotificationUrgency urgency
                required property string time
                required property int index

                width: ListView.view.width
                implicitHeight: cardCol.implicitHeight + Config.padding * 2

                anchors.margins: Config.padding
                color: Config.colors.surface
                radius: 8
                border.width: 2
                border.color: card.urgency === NotificationUrgency.Critical ? Config.colors.errorFg : Config.colors.border

                ColumnLayout {
                    id: cardCol
                    anchors.fill: parent
                    anchors.margins: Config.padding
                    spacing: Config.padding

                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 6

                        StyledText {
                            Layout.fillWidth: true
                            text: card.summary
                            color: Config.colors.infoFg
                            font.pixelSize: Config.font.base
                            font.weight: 600
                            elide: Text.ElideRight
                        }
                        StyledText {
                            text: card.time
                            color: Config.colors.textSecondary
                            font.pixelSize: Config.font.base - 2
                        }
                        StyledText {
                            text: "x"
                            color: Config.colors.textSecondary
                            font.pixelSize: Config.font.base - 2
                            MouseArea {
                                anchors.fill: parent
                                onClicked: root.history.remove(card.index)
                            }
                        }
                    }

                    StyledText {
                        Layout.fillWidth: true
                        visible: text !== ""
                        text: card.body
                        color: Config.colors.mutedFg
                        font.pixelSize: Config.font.base - 1
                        wrapMode: Text.WordWrap
                    }

                    StyledText {
                        Layout.fillWidth: true
                        visible: text !== ""
                        text: card.appName
                        color: Config.colors.textSecondary
                        font.pixelSize: Config.font.base - 4
                        wrapMode: Text.WordWrap
                    }
                }
            }
        }

        StyledText {
            visible: root.history.count === 0
            Layout.fillWidth: true
            Layout.fillHeight: true
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "No notifications"
            font.pixelSize: Config.font.base
        }
    }
}
