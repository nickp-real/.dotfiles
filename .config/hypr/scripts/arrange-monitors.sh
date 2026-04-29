#!/usr/bin/env bash

# shellcheck source=./hyprctl-helper.sh
source ~/.config/hypr/scripts/hyprctl-helper.sh

function arrange_monitor() {
  local main=$1
  local sec=$2

  local main_monitor_name
  local sec_monitor_name
  main_monitor_name=$(get_monitor_data "$main" "name")
  sec_monitor_name=$(get_monitor_data "$sec" "name")

  hyprctl eval "hl.monitor({ output = '$main_monitor_name', mode = 'highrr', position = '0x0', scale = 1 })" >/dev/null
  hyprctl eval "hl.monitor({ output = '$sec_monitor_name', mode = 'preferred', position = 'auto', scale = 1 })" >/dev/null
}
