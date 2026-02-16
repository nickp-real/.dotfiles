import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.commons
import qs.components

RowLayout {
    id: workspaceRow

    Repeater {
        model: Hyprland.workspaces

        Button {
            id: workspace
            required property HyprlandWorkspace modelData

            isActive: modelData.active
            property bool isFocused: Hyprland.focusedWorkspace?.id === modelData.id

            height: Theme.workspace.height
            width: Theme.workspace.width
            radius: Theme.workspace.radius
            color: isFocused || workspace.isHovered ? Theme.accentFg : isActive ? Theme.mutedBg : Theme.bg

            MouseArea {
                anchors.fill: parent
                onClicked: Hyprland.dispatch("workspace " + workspace.modelData.name)
            }

            Text {
                anchors {
                    verticalCenter: workspace.verticalCenter
                    horizontalCenter: workspace.horizontalCenter
                }
                text: workspace.modelData.name
                color: workspace.isFocused || workspace.isHovered ? Theme.accentBg : workspace.isActive ? Theme.mutedFg : Theme.fg

                Behavior on color {
                    ColorAnimation {
                        duration: 100
                    }
                }

                font {
                    pixelSize: FontStyle.md
                    bold: true
                    family: FontStyle.family
                }
            }
        }
    }
}
