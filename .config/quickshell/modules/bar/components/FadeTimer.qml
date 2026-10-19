import QtQuick

QtObject {
    property Timer open: Timer {
        interval: 80
    }
    property Timer close: Timer {
        interval: 100
    }

    function enter() {
        close.stop();
        open.restart();
    }

    function exit() {
        open.stop();
        close.restart();
    }
}
