sudo apt-get update && sudo apt-get upgrade -y

sudo apt install cmake scdoc pkg-config checkinstall git
cd Downloads

git clone https://github.com/ReimuNotMoe/ydotool
cd ydotool
mkdir build && cd build
cmake ..
make -j `nproc`

echo "Run the command below with the following settings"
echo "sudo checkinstall --fstrans=no"
echo "1. y"
echo "2. enter a description"
echo "3. press 2 then change the name to ydotool-custom"
echo "4. n"
echo "5. y"

sudo echo "YDOTOOL_SOCKET=/tmp/.ydotool_socket" >> ~/.profile

echo "Once done with that, log out then log back in, or reboot."