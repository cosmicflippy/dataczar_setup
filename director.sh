#!/usr/bin/bash
cd ~/dataczar

source venv/bin/activate
./gnome-randr.py --output HDMI-1 --rotate left

./venv/bin/python3 main.py