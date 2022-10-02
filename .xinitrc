[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

nvidia-settings --load-config-only &
./utils/monitor.sh &
setxkbmap -layout 'us(colemak_dh),th(ThaiMnc)' -option 'grp:win_space_toggle' &
exec awesome
