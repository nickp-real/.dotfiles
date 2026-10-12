import QtQuick

import "root:config.js" as Config

Rectangle {
    radius: Config.innerRadius
    color: Config.colors.surface

    Behavior on color {
        ColorAnimation {
            duration: 100
        }
    }
}
