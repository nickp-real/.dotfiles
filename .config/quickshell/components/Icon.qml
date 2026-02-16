pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import Quickshell
import Quickshell.Widgets
import qs.commons

Item {
    id: root

    property color color: Theme.fg
    property string source
    property bool colorization: true

    width: 30
    height: 30

    IconImage {
        anchors.fill: parent
        source: {
            if (root.source.startsWith("image://"))
                return root.source;

            const iconFolder = Qt.resolvedUrl(Quickshell.shellPath("assets/icons"));
            const iconSource = `${iconFolder}/${root.source}`;
            return iconSource;
        }

        layer.enabled: root.colorization
        layer.effect: MultiEffect {
            brightness: 1.0
            colorization: 1.0
            colorizationColor: root.color
        }
    }
}
