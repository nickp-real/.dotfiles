//@ pragma UseQApplication
import Quickshell
import QtQuick
import qs.modules.bar

// import qs.modules.notification
// import qs.modules.todo

Scope {

    Loader {
        active: true
        sourceComponent: Bar {}
    }

    // Todo {}
    //
    // Notification {}
}
