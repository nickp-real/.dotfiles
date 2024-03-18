#!/usr/bin/env bash
max_monitor_support=2
monitor_count=$(hyprctl monitors -j | jq '. | length')

if [[ "$monitor_count" -gt "$max_monitor_support" ]]; then
	echo "Not supported"
	exit
fi

# function bindws() {
# 	hyprctl keyword workspace "$2", "$1" >/dev/null
# 	hyprctl dispatch moveworkspacetomonitor "$1" "$2" >/dev/null
# }

# if [[ "$monitor_count" == 1 ]]; then
# 	monitor_1=$(hyprctl monitors -j | jq '.[0].name')
# 	for ((i = 1; i <= 10; i++)); do
# 		bindws $i "$monitor_1"
# 	done
# fi

# if [[ "$monitor_count" == 2 ]]; then
# 	monitor_1=$(hyprctl monitors -j | jq '.[0]')
# 	monitor_2=$(hyprctl monitors -j | jq '.[1]')
#   monitor_1_x=$(jq ".x" <<< "$monitor_1")

#   if [ "$monitor_1_x" == "0" ]; then
# 		primary_monitor=$(jq ".name" <<<"$monitor_1")
# 		secondary_monitor=$(jq ".name" <<<"$monitor_2")
#   else
# 		primary_monitor=$(jq ".name" <<<"$monitor_2")
# 		secondary_monitor=$(jq ".name" <<<"$monitor_1")
#   fi

# 	for ((i = 1; i <= 5; i++)); do
# 		bindws $i "$primary_monitor"
# 	done

# 	for ((i = 6; i <= 10; i++)); do
# 		bindws $i "$secondary_monitor"
# 	done
# fi

monitor=$(hyprctl monitors -j | jq '.[1].name' | tr -d '"')

if [[ "$monitor" == "DP-2" ]]; then
  hyprctl dispatch moveworkspacetomonitor 1 "$monitor" > /dev/null

  hyprctl dispatch workspace 6 > /dev/null
  hyprctl dispatch moveworkspacetomonitor 6 eDP-1 > /dev/null

  hyprctl dispatch workspace 1 > /dev/null
fi
