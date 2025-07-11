#!/bin/bash
sudo apt update -y
sudo apt full-upgrade -y
sudo apt install python3 python3-pip python3-venv -y

mkdir dataczar
cd dataczar
python3 -m venv venv
source venv/bin/activate

pip install playwright
playwright install

pip install python-dotenv

curl -sSL https://raw.githubusercontent.com/cosmicflippy/dataczar_setup/refs/heads/main/main.py -o main.py

curl -sSL https://raw.githubusercontent.com/cosmicflippy/dataczar_setup/refs/heads/main/dataczar.service -o dataczar.service

curl -sSL https://raw.githubusercontent.com/cosmicflippy/dataczar_setup/refs/heads/main/.env.sample -o .env

mv dataczar.service /etc/systemd/system/dataczar.service
sudo systemctl daemon-reload
sudo systemctl enable dataczar.service

echo "Please set your environment variables in the .env file, then reboot your device."