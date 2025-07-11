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

python3 main.py