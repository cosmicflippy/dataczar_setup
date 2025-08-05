#!/usr/bin/bash
cd /home/admin/dataczar

source venv/bin/activate
sudo bash ./gnome-randr.py --output HDMI-1 --rotate left

./venv/bin/python3 main.py