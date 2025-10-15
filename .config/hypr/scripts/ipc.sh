#!/usr/bin/env bash

function handle() {
  case $1 in
  monitoradded*) ~/.config/hypr/scripts/monitor.sh ;;
  esac
}

socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR"/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock | while read -r line; do handle "$line"; done
