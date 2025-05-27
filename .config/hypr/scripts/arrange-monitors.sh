#!/usr/bin/env bash

max_monitor_support=2
monitor_count=$(hyprctl monitors -j | jq '. | length')

if [[ "$monitor_count" -gt "$max_monitor_support" || "$monitor_count" -eq 1 ]]; then
  echo "Not supported"
  exit
fi

# shellcheck source=./hyprctl-helper.sh
source ~/.config/hypr/scripts/hyprctl-helper.sh

default_monitor="eDP-1"
default_monitor_data=$(get_monitor_from_index 0)
monitor=$(get_monitor_from_index 1)
monitor_name=$(get_monitor_data "$monitor" 'name')
if [[ "$monitor_name" -eq "$default_monitor" ]]; then
  monitor=$(get_monitor_from_index 0)
  monitor_name=$(get_monitor_data "$monitor" 'name')
  default_monitor_data=$(get_monitor_from_index 1)
fi

default_monitor_width=$(get_monitor_data "$default_monitor_data" "width")
monitor_width=$(get_monitor_data "$monitor" "width")

case $monitor_name in
"DP-2")
  hyprctl keyword monitor "$default_monitor",highrr,"$monitor_width"x0,1 >/dev/null
  hyprctl keyword monitor "$monitor_name",highrr,0x0,1 >/dev/null
  ;;
esac
