pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell
import QtQuick

Singleton {
    id: theme

    property string themeName: "onedark"

    property color bg: "#282c34"
    property color fg: "#c8ccd4"

    property color accentBg: bg
    property color accentFg: "#61afef"

    property color mutedBg: "#353b45"
    property color mutedFg: "#c8ccd4"

    property int radius: 8
    property int innerRadius: radius / 2

    property var bar: ({
            height: 48,
            radius,
            leftRightGap: 8,
            topBottomGap: 8,
            insideMargin: 8
        })

    property var workspace: ({
            height: 24,
            width: 24,
            radius: innerRadius
        })

    property var slider: ({
            width: 32,
            height: 32,
            radius: innerRadius * 3,
            icon: ({
                    width: 24,
                    height: 24
                })
        })
}
