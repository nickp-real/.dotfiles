pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    property var vpnList
    property bool anyActive: (vpnList ?? []).some(v => v.active)

    Process {
        id: list
        command: ["nmcli", "-t", "-f", "NAME,UUID,TYPE,ACTIVE", "connection", "show"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                vpnList = this.text.split("\n").slice(0, -1).map(text => {
                    const data = text.split(":");
                    const active = data.pop();
                    const type = data.pop();
                    const uuid = data.pop();
                    const name = data.join(":");
                    return {
                        name,
                        uuid,
                        type,
                        active: active === "yes" ? true : false
                    };
                }).filter(({
                        type
                    }) => type.includes("vpn") || type.includes("wireguard"));
            }
        }
    }

    Timer {
        interval: 30000
        repeat: true
        running: true
        onTriggered: listVPN()
    }

    Process {
        id: connect
        stdout: StdioCollector {
            onStreamFinished: {
                listVPN();
            }
        }
        stderr: SplitParser {}
    }

    Process {
        id: disconnect
        stdout: StdioCollector {
            onStreamFinished: {
                listVPN();
            }
        }
        stderr: SplitParser {}
    }

    function listVPN() {
        if (list.running)
            return;
        list.running = true;
    }

    function connect(uuid: string) {
        connect.command = ["nmcli", "connection", "up", uuid];
        connect.running = true;
    }

    function disconnect(uuid: string) {
        disconnect.command = ["nmcli", "connection", "down", uuid];
        disconnect.running = true;
    }
}
