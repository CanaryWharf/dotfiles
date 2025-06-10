pamixer "$@"
pactl play-sample audio-volume-change
if [ "$1" == "mute" ] && [ $(amixer get Master | grep -c off) == "2" ]
then
    volnoti-show -m
else
    volnoti-show $(amixer get Master | grep -Po "[0-9]+(?=%)" | tail -1)
   # canberra-gtk-play -i message
fi
#pkill -USR1 py3status
pkill -RTMIN+10 i3blocks
