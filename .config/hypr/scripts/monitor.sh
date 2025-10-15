#!/usr/bin/env bash

max_monitor_support=2
monitor_count=$(hyprctl monitors -j | jq '. | length')

if [[ "$monitor_count" -gt "$max_monitor_support" || "$monitor_count" -eq 1 ]]; then
  echo "Not supported"
  exit
fi

# shellcheck source=./hyprctl-helper.sh
source ~/.config/hypr/scripts/hyprctl-helper.sh
# shellcheck source=./arrange-workspaces.sh
source ~/.config/hypr/scripts/arrange-workspaces.sh
# shellcheck source=./arrange-monitors.sh
source ~/.config/hypr/scripts/arrange-monitors.sh

default_monitor_name="eDP-1"

default_monitor_data=$(get_monitor_from_index 0)
monitor_data=$(get_monitor_from_index 1)
monitor_name=$(get_monitor_data "$monitor_data" 'name')
if [[ "$monitor_name" -eq "$default_monitor_name" ]]; then
  temp=$monitor_data
  monitor_data=$default_monitor_data
  monitor_name=$(get_monitor_data "$monitor_data" 'name')
  default_monitor_data=$temp
fi

function arrange() {
  local main=$1
  local sec=$2

  arrange_monitor "$main" "$sec"
  bind_workspace_to_monitor "$main" "$sec"
}

case $monitor_name in
"DP-2")
  arrange "$monitor_data" "$default_monitor_data"
  ;;
*)
  arrange "$default_monitor_data" "$monitor_data"
  ;;
esac
