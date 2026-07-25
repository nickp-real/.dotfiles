import QtQuick
import qs.commons
import qs.components

Button {
    id: dashboardButton

    onClicked: {
        GlobalStates.dashboardOpen = !GlobalStates.dashboardOpen;
    }

    Icon {
        source: "dashboard.svg"
    }
}
