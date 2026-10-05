import QtQuick

import "root:config.js" as Config

Text {
    font {
        family: Config.font.family
        pixelSize: Config.font.md
    }
    color: Config.colors.fg
}
