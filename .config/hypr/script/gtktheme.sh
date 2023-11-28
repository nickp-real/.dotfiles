#!/usr/bin/env bash

theme='OneDark'
icon='Papirus-Dark'
font='Roboto 12'
cursor='Bibata-Modern-Ice'

schema='gsettings set org.gnome.desktop.interface'

apply_themes(){
  ${schema} gtk-theme "${theme}"
  ${schema} icon-theme "${icon}"
  ${schema} cursor-theme "${cursor}"
  ${schema} font-name "${font}"
}

apply_themes
