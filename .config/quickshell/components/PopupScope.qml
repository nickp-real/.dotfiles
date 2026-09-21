import Quickshell
import Quickshell.Io

Scope {
    id: root
    required property string name
    property bool open: false

    IpcHandler {
        target: root.name
        function toggle(): void {
            root.open = !root.open;
        }
        function show(): void {
            root.open = true;
        }
        function hide(): void {
            root.open = false;
        }
    }
}
