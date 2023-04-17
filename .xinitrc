[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

nvidia-settings --load-config-only &
