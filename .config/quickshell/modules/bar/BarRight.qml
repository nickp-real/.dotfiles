import QtQuick.Layouts
import QtQuick
import qs.modules.bar.components.dashboard
import qs.modules.bar.components

Item {
    implicitWidth: layout.implicitWidth
    implicitHeight: layout.implicitHeight

    RowLayout {
        id: layout
        anchors.fill: parent

        BarContainer {
            DashboardButton {
                id: dashboardButton
                anchors.centerIn: parent
                onClicked: dashboard.visible = !dashboard.visible
            }
        }
    }

    Dashboard {
        id: dashboard
        anchor.item: dashboardButton
    }
}
