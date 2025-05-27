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

bind_monitor() {
  local main=$1
  local sec=$2
  local main_name
  local sec_name
  main_name=$(get_monitor_data "$main" "name")
  sec_name=$(get_monitor_data "$sec" "name")
  hyprctl keyword workspace 1,monitor:"$main_name",default:true >/dev/null
  hyprctl keyword workspace 6,monitor:"$sec_name",default:true >/dev/null

  hyprctl dispatch moveworkspacetomonitor 1 "$main_name" >/dev/null

  hyprctl dispatch workspace 6 >/dev/null
  hyprctl dispatch moveworkspacetomonitor 6 "$sec_name" >/dev/null

  hyprctl dispatch workspace 1 >/dev/null
}

case $monitor_name in
"DP-2")
  bind_monitor "$monitor" "$default_monitor_data"
  ;;
*)
  bind_monitor "$default_monitor_data" "$monitor"
  ;;
esac
