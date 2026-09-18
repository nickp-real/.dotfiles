import QtQuick
import QtQuick.Layouts

import "root:config.js" as Config

Rectangle {
    color: Config.colors.bg
    radius: Config.bar.radius

    Layout.fillHeight: true
    Layout.preferredWidth: childrenRect.width + 8 * 2
    Layout.leftMargin: Config.padding
    Layout.rightMargin: Config.padding
    Layout.topMargin: Config.padding
    // Layout.bottomMargin: Config.padding / 2
}
