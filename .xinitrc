[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

systemctl --user import-environment DISPLAY

export LIBVA_DRIVER_NAME=nvidia

# increase repeat rate
xset r rate 230 40

# set resolution and refresh rate
xrandr --output DP-0 --primary --mode 2560x1440 --rate 144

setxkbmap -model pc105 -layout us,ru -variant qwerty -option grp:alt_shift_toggle,caps:escape
picom --config $HOME/.config/picom/picom.conf -b

# restore background image
~/.fehbg &

# turn bell off
xset b off

exec i3
