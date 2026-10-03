//@ pragma UseQApplication
import Quickshell
import QtQuick

import qs.modules.bar
import qs.modules.notification
import qs.modules.startup_menu
import qs.modules.app_launcher
import qs.modules.wallpaper

// import qs.modules.todo

Scope {

    Loader {
        active: true
        sourceComponent: Bar {}
    }

    // Todo {}
    //
    Notification {}
    StartupMenu {}
    AppLauncher {}
    Wallpaper {}
}
