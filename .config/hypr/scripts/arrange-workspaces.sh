#!/usr/bin/env bash

# shellcheck source=./hyprctl-helper.sh
source ~/.config/hypr/scripts/hyprctl-helper.sh

function bind_workspace_to_monitor() {
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
