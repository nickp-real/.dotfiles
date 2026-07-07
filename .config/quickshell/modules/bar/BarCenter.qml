import QtQuick.Layouts
import qs.modules.bar.components
import QtQuick

RowLayout {
    BarContainer {
        Clock {
            anchors.centerIn: parent
        }
    }
}
