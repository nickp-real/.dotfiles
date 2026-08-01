import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.components

import "root:config.js" as Config

RowLayout {
    id: workspaceRow
    spacing: 4

    Repeater {
        model: Hyprland.workspaces

        Button {
            id: workspace
            required property HyprlandWorkspace modelData

            property bool isActive: modelData.active
            property bool isWorkspaceFocused: Hyprland.focusedWorkspace?.id === modelData.id

            color: isWorkspaceFocused || workspace.isHovered ? Config.colors.accentFg : isActive ? Config.colors.mutedBg : Config.colors.bg

            onClicked: Hyprland.dispatch("workspace " + workspace.modelData.name)

            Text {
                anchors {
                    verticalCenter: workspace.verticalCenter
                    horizontalCenter: workspace.horizontalCenter
                }
                text: workspace.modelData.name
                color: isWorkspaceFocused || workspace.isHovered ? Config.colors.accentBg : workspace.isActive ? Config.colors.mutedFg : Config.colors.fg

                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }

                font {
                    bold: true
                    pixelSize: Config.font.md
                    family: Config.font.family
                }
            }
        }
    }
}
