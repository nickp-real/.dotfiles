#!/usr/bin/env bash
max_monitor_support=2
monitor_count=$(hyprctl monitors -j | jq '. | length')

if [[ "$monitor_count" -gt "$max_monitor_support" || "$monitor_count" -eq 1 ]]; then
  echo "Not supported"
  exit
fi

default_monitor="eDP-1"

monitor=$(hyprctl monitors -j | jq '.[1].name' | tr -d '"')
if [[ "$monitor" -eq "$default_monitor" ]]; then
  monitor=$(hyprctl monitors -j | jq '.[0].name' | tr -d '"')
fi

bind_monitor() {
  main=$1
  sec=${2:-default_monitor}
  hyprctl keyword workspace 1,monitor:"$main",default:true >/dev/null
  hyprctl keyword workspace 6,monitor:"$sec",default:true >/dev/null

  hyprctl dispatch moveworkspacetomonitor 1 "$main" >/dev/null

  hyprctl dispatch workspace 6 >/dev/null
  hyprctl dispatch moveworkspacetomonitor 6 "$sec" >/dev/null

  hyprctl dispatch workspace 1 >/dev/null
}

echo "$monitor" "$default_monitor"

if [[ "$monitor" == "DP-2" ]]; then
  bind_monitor "$monitor"
else
  bind_monitor "$default_monitor" "$monitor"
fi
