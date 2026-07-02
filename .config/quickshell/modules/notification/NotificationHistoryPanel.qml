import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

import "root:config.js" as Config

PanelWindow {
    id: root
    required property ListModel history

    anchors {
        top: true
        right: true
    }
    implicitWidth: 380
    implicitHeight: Math.min(centerCol.implicitHeight + Config.padding * 2, 300)

    margins {
        top: Config.bar.height + Config.padding
        right: Config.padding
    }

    color: "transparent"
    exclusionMode: ExclusionMode.Ignore

    Rectangle {
        anchors.fill: parent
        radius: 8
        color: Config.colors.bg
        border.width: 2
        border.color: Config.colors.white

        ColumnLayout {
            id: centerCol
            anchors.fill: parent
            anchors.margins: Config.padding
            spacing: Config.padding

            RowLayout {
                Layout.fillWidth: true

                Text {
                    Layout.fillWidth: true
                    text: "Notifications"
                    color: Config.colors.cyan
                    font.family: Config.font.family
                    font.pixelSize: Config.font.size + 2
                    font.bold: true
                }

                Text {
                    text: "Clear all"
                    visible: root.history.count > 0
                    color: Config.colors.red
                    font.family: Config.font.family
                    font.pixelSize: Config.font.size - 2
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
                    color: Config.colors.bg
                    radius: 8
                    border.width: 2
                    border.color: card.urgency === NotificationUrgency.Critical ? Config.colors.red : Config.colors.white

                    ColumnLayout {
                        id: cardCol
                        anchors.fill: parent
                        anchors.margins: Config.padding
                        spacing: Config.padding

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 6

                            Text {
                                Layout.fillWidth: true
                                text: card.summary
                                color: Config.colors.cyan
                                font.family: Config.font.family
                                font.pixelSize: Config.font.size
                                font.bold: true
                                elide: Text.ElideRight
                            }
                            Text {
                                text: card.time
                                color: Config.colors.brightBlack
                                font.family: Config.font.family
                                font.pixelSize: Config.font.size - 2
                            }
                            Text {
                                text: "x"
                                color: Config.colors.brightBlack
                                font.family: Config.font.family
                                font.pixelSize: Config.font.size - 2
                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: root.history.remove(card.index)
                                }
                            }
                        }

                        Text {
                            Layout.fillWidth: true
                            visible: text !== ""
                            text: card.body
                            color: Config.colors.mutedFg
                            font.family: Config.font.family
                            font.pixelSize: Config.font.size - 1
                            wrapMode: Text.WordWrap
                        }

                        Text {
                            Layout.fillWidth: true
                            visible: text !== ""
                            text: card.appName
                            color: Config.colors.brightBlack
                            font.family: Config.font.family
                            font.pixelSize: Config.font.size - 4
                            wrapMode: Text.WordWrap
                        }
                    }
                }
            }

            Text {
                visible: root.history.count === 0
                Layout.alignment: Qt.AlignCenter
                text: "No notifications"
                color: Config.colors.fg
                font.family: Config.font.family
                font.pixelSize: Config.font.size
            }
        }
    }
}
