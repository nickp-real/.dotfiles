[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

setxkbmap -layout 'us(colemak_dh),th(ThaiMnc)' -option 'grp:win_space_toggle'
exec awesome
