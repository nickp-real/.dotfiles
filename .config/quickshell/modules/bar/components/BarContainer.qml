import QtQuick

import "root:config.js" as Config

Rectangle {
    color: Config.colors.bg
    height: Config.bar.height
    implicitWidth: childrenRect.width + Config.padding * 2
}
