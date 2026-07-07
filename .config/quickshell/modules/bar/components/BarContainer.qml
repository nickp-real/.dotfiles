import QtQuick
import QtQuick.Layouts
import qs.commons

Rectangle {
    color: Theme.bg
    radius: Theme.bar.radius

    Layout.fillHeight: true
    Layout.preferredWidth: childrenRect.width + 8 * 2
    Layout.margins: 8
}
