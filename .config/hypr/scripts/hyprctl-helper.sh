#!/usr/bin/env bash

function get_monitor_from_index() {
  local index=$1
  hyprctl monitors -j | jq ".[${index}]"
}

function get_monitor_data() {
  local monitor_data=$1
  local key=$2
  jq -n "$monitor_data" | jq ".${key}" | tr -d '"'
}
