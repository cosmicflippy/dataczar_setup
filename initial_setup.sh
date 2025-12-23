#!/bin/sh
sudo apt-get update && sudo apt-get upgrade -y

curl -sSL https://raw.githubusercontent.com/cosmicflippy/dataczar_setup/refs/heads/main/kiosk.sh -o kiosk.sh
curl -sSL https://raw.githubusercontent.com/cosmicflippy/dataczar_setup/refs/heads/main/.env -o .env


echo "Finished upgrading. Downloading dependencies..."

sleep 2

sudo apt install cmake scdoc pkg-config checkinstall git software-properties-common firefox-esr -y
echo "Finished installing dependencies. Setting up ydotool..."
cd Downloads

git clone https://github.com/ReimuNotMoe/ydotool
cd ydotool
mkdir build && cd build
cmake ..
make -j `nproc`

echo "Setting up ydotool..."
sleep 2
cd Downloads/ydotool/build
sudo checkinstall --default \ --pkgname="ydotool-custom" --fstrans=no

echo "Running the commands..."
cd ~/Downloads/ydotool/build && sudo mv ydotoold.service /etc/systemd/system/
sudo systemctl enable ydotoold && sudo systemctl start ydotoold
sudo echo 'export YDOTOOL_SOCKET=/tmp/.ydotool_socket' >> ~/.profile
echo "Setting up permissions..."
sudo chown -R $USER:$USER /tmp/.ydotool_socket
sudo chmod -R 660 /tmp/.ydotool_socket

echo "Reboot and run the kiosk.sh script"