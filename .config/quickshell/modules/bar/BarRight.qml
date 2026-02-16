import QtQuick.Layouts
import qs.modules.bar.components.dashboard
import qs.commons

RowLayout {
    anchors.right: parent.right
    anchors.verticalCenter: parent.verticalCenter
    anchors.rightMargin: Theme.bar.insideMargin

    DashboardButton {}
}
