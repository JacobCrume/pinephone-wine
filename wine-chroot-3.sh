#!/bin/bash

echo "Updating chroot"
apt update && apt upgrade
apt install git wget cmake build-essential python3
apt install gcc-arm-linux-gnueabihf

echo "Downloading Box86"
git clone https://github.com/ptitSeb/box86
cd box86

echo "Building Box86"
mkdir build; cd build; cmake .. -DARM_DYNAREC=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo; make
exit
