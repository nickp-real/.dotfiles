#!/usr/bin/env bash

theme='OneDark'
icon='Papirus-Dark'
font='Roboto 10'
cursor='Bibata-Modern-Ice'
color_scheme='prefer-dark'

schema='gsettings set org.gnome.desktop.interface'

apply_themes() {
  ${schema} gtk-theme "${theme}"
  ${schema} icon-theme "${icon}"
  ${schema} cursor-theme "${cursor}"
  ${schema} font-name "${font}"
  ${schema} color-scheme "${color_scheme}"
}

apply_themes
