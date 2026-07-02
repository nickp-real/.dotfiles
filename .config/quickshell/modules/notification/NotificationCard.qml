import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

import "root:config.js" as Config

Rectangle {
    id: card
    required property Notification modelData

    Layout.fillWidth: true
    Layout.preferredHeight: layout.implicitHeight + 20
    color: Config.colors.bg
    radius: 8
    border.width: 2
    border.color: modelData.urgency === NotificationUrgency.Critical ? Config.colors.red : Config.colors.white

    Timer {
        running: card.modelData.urgency !== NotificationUrgency.Critical
        interval: Config.notifications.timeout
        onTriggered: card.modelData.dismiss()
    }

    RowLayout {
        id: layout
        anchors.fill: parent
        anchors.margins: Config.padding
        spacing: Config.padding

        Image {
            Layout.preferredHeight: 36
            Layout.preferredWidth: 36
            Layout.alignment: Qt.AlignTop
            fillMode: Image.PreserveAspectFit
            visible: source.toString() !== ""
            source: card.modelData.image || card.modelData.appIcon || ""
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 2

            Text {
                Layout.fillWidth: true
                text: card.modelData.summary
                color: Config.colors.cyan
                font.family: Config.font.family
                font.pixelSize: Config.font.size
                font.bold: true
                elide: Text.ElideRight
            }

            Text {
                Layout.fillWidth: true
                visible: text !== ""
                text: card.modelData.body
                color: Config.colors.mutedFg
                font.family: Config.font.family
                font.pixelSize: Config.font.size - 1
                wrapMode: Text.WordWrap
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: card.modelData.dismiss()
    }
}
