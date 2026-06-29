import QtQuick.Layouts
import qs.modules.bar.components
import qs.commons
import QtQuick

RowLayout {
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    anchors.leftMargin: Theme.bar.insideMargin

    WorkSpaces {}
}
