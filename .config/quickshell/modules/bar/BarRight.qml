import QtQuick.Layouts
import QtQuick
import qs.modules.bar.components.dashboard
import qs.modules.bar.components
import qs.commons

RowLayout {
    BarContainer {
        DashboardButton {
            anchors.centerIn: parent
        }
    }
}
