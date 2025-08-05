#!/usr/bin/bash

set -e

sudo apt update -y
sudo apt full-upgrade -y
sudo apt install python3 python3-pip python3-venv -y

mkdir dataczar
cd dataczar

python3 -m venv venv
source venv/bin/activate

pip install playwright
pip install python-dotenv
pip install dbus-python

playwright install
playwright install-deps

echo "Grabbing setup files..."

sudo curl -sSL https://raw.githubusercontent.com/cosmicflippy/dataczar_setup/refs/heads/main/gnome-randr.py -o gnome-randr.py
sudo curl -sSL https://raw.githubusercontent.com/cosmicflippy/dataczar_setup/refs/heads/main/main.py -o main.py
sudo curl -sSL https://raw.githubusercontent.com/cosmicflippy/dataczar_setup/refs/heads/main/director.sh -o director.sh

echo "Successfully grabbed files."

echo "Setting up the .env file..."
if [ ! -f .env ]; then
    echo "Creating .env file from sample..."
    sudo curl -sSL "https://raw.githubusercontent.com/cosmicflippy/dataczar_setup/refs/heads/main/.env.sample" -o .env
else
    echo ".env file already exists. Please edit it as needed."
fi

chmod +x gnome-randr.py

(crontab -l 2>/dev/null; echo "*/5 * * * * ~/dataczar/director.sh") | crontab -

echo "Please set your environment variables in the .env file, then reboot your device."