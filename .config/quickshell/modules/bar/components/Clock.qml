import QtQuick
import qs.modules.bar.services
import qs.commons

Text {
    text: Time.time
    color: Theme.fg
    font.bold: true
    font.pixelSize: FontStyle.md
    font.family: FontStyle.family
}
