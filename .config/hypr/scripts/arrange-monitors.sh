#!/usr/bin/env bash

# shellcheck source=./hyprctl-helper.sh
source ~/.config/hypr/scripts/hyprctl-helper.sh

function arrange_monitor() {
  local main=$1
  local sec=$2

  local main_monitor_width
  main_monitor_width=$(get_monitor_data "$main" "width")

  local main_monitor_name
  local sec_monitor_name
  main_monitor_name=$(get_monitor_data "$main" "name")
  sec_monitor_name=$(get_monitor_data "$sec" "name")

  hyprctl keyword monitor "$main_monitor_name", highrr, 0x0, 1 >/dev/null
  hyprctl keyword monitor "$sec_monitor_name", preferred, auto, 1 >/dev/null
}
