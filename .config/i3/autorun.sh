setxkbmap -layout us,ru,ua -variant -option grp:ctrl_shift_toggle,grp_led:scroll,terminate:ctrl_alt_bksp,compose:ralt
xrdb ~/.Xresources
nitrogen --restore
picom
xrandr --output eDP1 --auto --output DP1 --auto --right-of eDP1 --output HDMI1 --auto --left-of eDP1
