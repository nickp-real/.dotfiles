import QtQuick
import qs.commons
import qs.components

Button {
    id: dashboardButton

    width: 20
    height: 20

    Icon {
        anchors.fill: parent
        source: "dashboard.svg"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                GlobalStates.dashboardOpen = !GlobalStates.dashboardOpen;
            }
        }
    }
}
