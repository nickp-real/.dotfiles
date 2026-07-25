import QtQuick
import qs.modules.bar.services

import "root:config.js" as Config

Text {
    text: Time.time
    color: Config.colors.fg
    font.bold: true
    font.pixelSize: Config.font.md
    font.family: Config.font.family
}
