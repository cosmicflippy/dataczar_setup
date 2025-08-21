#!/bin/sh
WAYLAND_DISPLAY=wayland-1 MOZ_ENABLE_WAYLAND=1 firefox-esr --kiosk "https://cnc.churchill-realestate.com" &

set -a
source .env
set +a

sleep 5
ydotool key 56:1 15:1 15:0 56:0 #alt + tab
sleep 1
ydotool key 15:1 15:0 #tab key
ydotool key 15:1 15:0
sleep 2
ydotool type $USERNAME
sleep 2
ydotool key 15:1 15:0 #tab key
ydotool type $PASSWORD
sleep 2
ydotool key 28:1 28:0 #enter key
sleep 10
ydotool key 15:1 15:0 #tab key 6 times
ydotool key 15:1 15:0
ydotool key 15:1 15:0
ydotool key 15:1 15:0
ydotool key 15:1 15:0
ydotool key 15:1 15:0
sleep 1
ydotool key 15:1 15:0
ydotool key 28:1 28:0 #enter key