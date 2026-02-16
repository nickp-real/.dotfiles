pragma Singleton
pragma ComponentBehavior: Bound
import Quickshell

Singleton {
    id: root
    property bool todoOpen: false
    property bool dashboardOpen: false
}
