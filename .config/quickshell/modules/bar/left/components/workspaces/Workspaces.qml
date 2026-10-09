import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.components

import "root:config.js" as Config

Item {
    implicitHeight: parent.height
    implicitWidth: workspaceRow.implicitWidth

    Row {
        id: workspaceRow
        spacing: 4

        Repeater {
            model: Hyprland.workspaces

            Button {
                id: workspace
                required property HyprlandWorkspace modelData

                property bool isActive: modelData.active
                property bool isWorkspaceFocused: Hyprland.focusedWorkspace?.id === modelData.id

                hoverEnabled: true
                style.color: isWorkspaceFocused || workspace.hovered ? Config.colors.accentFg : isActive ? Config.colors.mutedBg : Config.colors.bg

                onClicked: Quickshell.execDetached(["hyprctl", "dispatch", `hl.dsp.focus({workspace = ${workspace.modelData.name}})`])

                contentItem: StyledText {
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    text: workspace.modelData.name
                    color: workspace.isWorkspaceFocused || workspace.hovered ? Config.colors.accentBg : workspace.isActive ? Config.colors.mutedFg : Config.colors.fg

                    Behavior on color {
                        ColorAnimation {
                            duration: 100
                        }
                    }

                    font.weight: 600
                }
            }
        }
    }
}
