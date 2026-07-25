pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets

import "root:config.js" as Config

Item {
    id: root

    property color color: Config.colors.fg
    property string source
    property bool colorization: true

    implicitWidth: Config.icon.width
    implicitHeight: Config.icon.height

    anchors.verticalCenter: parent.verticalCenter
    anchors.horizontalCenter: parent.horizontalCenter

    IconImage {
        anchors.fill: parent
        source: {
            if (root.source.startsWith("image://"))
                return root.source;

            if (root.source.endsWith(".svg")) {
                const iconFolder = Qt.resolvedUrl(Quickshell.shellPath("assets/icons"));
                const iconSource = `${iconFolder}/${root.source}`;
                return iconSource;
            }

            return Qt.resolvedUrl(`/usr/share/icons/${Quickshell.env("QS_ICON_THEME")}/24x24/symbolic/status/${root.source}.svg`);
        }

        layer.enabled: root.colorization
        layer.effect: MultiEffect {
            brightness: 1.0
            colorization: 1.0
            colorizationColor: root.color
        }
    }
}
