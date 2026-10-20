import QtQuick
import Quickshell

PanelWindow {
    id: root
    required property ShellScreen modelData
    screen: modelData
    property alias container: container
    property alias delay: delay
    default property alias content: container.content
    signal openTriggered
    signal closeTriggered

    exclusionMode: ExclusionMode.Ignore
    color: "transparent"

    mask: Region {
        item: container
        bottomLeftRadius: container.bottomLeftRadius
        bottomRightRadius: container.bottomRightRadius
        topLeftRadius: container.topLeftRadius
        topRightRadius: container.topRightRadius
    }

    FadeTimer {
        id: delay
        open.onTriggered: root.openTriggered()
        close.onTriggered: root.closeTriggered()
    }

    HoverHandler {
        onHoveredChanged: {
            if (hovered) {
                delay.enter();
            } else {
                delay.exit();
            }
        }
    }

    BarContainer {
        id: container
    }
}
