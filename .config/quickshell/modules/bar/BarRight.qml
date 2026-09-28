import QtQuick
import Quickshell
import qs.modules.bar.components.dashboard
import qs.modules.bar.components

import "root:config.js" as Config

Variants {
    model: Quickshell.screens

    PanelWindow {
        required property ShellScreen modelData
        screen: modelData

        anchors {
            top: true
            right: true
        }

        exclusionMode: ExclusionMode.Ignore
        color: "transparent"

        implicitHeight: Config.bar.height
        implicitWidth: container.implicitWidth

        BarContainer {
            id: container
            bottomLeftRadius: Config.bar.radius

            DashboardButton {
                id: dashboardButton
                anchors.centerIn: parent
                onClicked: dashboard.visible = !dashboard.visible
                HoverHandler {
                    id: hover
                }
            }
        }

        Dashboard {
            id: dashboard
            anchor.item: dashboardButton
        }
    }
}
