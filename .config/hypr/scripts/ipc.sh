#!/usr/bin/env bash

handle() {
  case $1 in
  monitoradded*) ~/.config/hypr/scripts/arrange-monitors.sh && ~/.config/hypr/scripts/arrange-workspaces.sh ;;
  esac
}

socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR"/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock | while read -r line; do handle "$line"; done
