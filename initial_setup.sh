#!/bin/sh
sudo apt-get update && sudo apt-get upgrade -y

curl -sSL https://raw.githubusercontent.com/cosmicflippy/dataczar_setup/refs/heads/main/kiosk.sh -o kiosk.sh
curl -sSL https://raw.githubusercontent.com/cosmicflippy/dataczar_setup/refs/heads/main/.env -o .env

echo "Finished upgrading. Downloading dependencies..."

sleep(3)

sudo apt install cmake scdoc pkg-config checkinstall git software-properties-common firefox-esr -y
echo "Finished installing dependencies. Setting up ydotool..."
cd Downloads

git clone https://github.com/ReimuNotMoe/ydotool
cd ydotool
mkdir build && cd build
cmake ..
make -j `nproc`

echo "Run the commands below with the following settings"
echo "Change to Wayfire in raspi-config > System options > Advanced"
sudo "Go into keyboard settings (top left) Change keyboard locale to UK, then back to US. Doesn't seem to want to work on setup."
echo ""
echo "ydotool is ready to be configured/setup. Follow the instructions below."
echo "Command 1: cd Downloads/ydotool/build"
echo "Command 2: sudo checkinstall --fstrans=no"
echo "Follow these instructions for each step."
echo "1. y"
echo "2. Enter a description. Something like 'automated keyboard'"
echo "3. press 2 then change the name to ydotool-custom"
echo "4. n"
echo "5. y"

sudo echo "export YDOTOOL_SOCKET=/tmp/.ydotool_socket" >> ~/.profile

echo "Change the screen orientation through the GUI"
echo "Once done with all of that, reboot."