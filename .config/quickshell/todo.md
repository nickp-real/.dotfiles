- [x] Rescan button + scanning spinner — no manual scan trigger
- [x] Known joins without retype — Network.qml:207,215 forces passwordField.text.length > 0 even when known == true. Saved net should allow empty-field Connect via network.connect()
- [ ] EAP guard — services/NetworkService.qml:72 sends any needsPassword to connectWithPsk. Work WpaEap fails. Check isPsk first, else show Use nmcli
- [x] Forget confirm — Network.qml:194 deletes at once, no Sure? second tap, do it as hold button
- [ ] Wired card — only wifiNetworks exposed
- [ ] Multi-profile — all nmSettings[0] only, no connectWithSettings pick
      ~~- [ ] Saved far away section — no list for saved but out of range~~
- [ ] List height fixed Network.qml:30 at 120, clips long scans
- [ ] VPN — needs nmcli helper, Quickshell has no VPN type
