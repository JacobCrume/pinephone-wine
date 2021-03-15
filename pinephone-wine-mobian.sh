#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "This script will install wine on your Pinephone. It should take less than 1 hour depending on you internet connection speed."
echo "First we need to install some dependencies."
sleep 5

apt install -y schroot debootstrap

echo "Creating folders"
sleep 2
mkdir /srv/chroot
mkdir /srv/chroot/debian-armhf


echo "Running debootstrap"
sleep 2
debootstrap --arch armhf --foreign buster /srv/chroot/debian-armhf http://debian.xtdv.net/debian

echo "Entering chroot jail"
sleep 2
chroot "/srv/chroot/debian-armhf" /debootstrap/debootstrap --second-stage

echo "Creating configuration files"
sleep 2
cp debian-armhf.conf /etc/schroot/chroot.d
cp nssdatabases /etc/schroot/desktop/nssdatabases
cp stateoverride /srv/chroot/debian-armhf/var/lib/dpkg/statoverride

echo "Entering chroot"
sleep 2
cat << EOF | schroot -c debian-armhf
printf 'export LANGUAGE="C"\nexport LC_ALL="C"\nexport DISPLAY=:0' >> ~/.bashrc
EOF
cat << EOF | schroot -c debian-armhf
echo "You need to enter your password. This is used for the 32 bit arm root account"
passwd
echo "Updating chroot"
apt update
apt install -y git wget cmake build-essential python3
apt install -y gcc-arm-linux-gnueabihf
echo "Installing wine dependencies"
apt install -y zenity
adduser mobian
su - mobian
printf 'export LANGUAGE="C"\nexport LC_ALL="C"\nexport DISPLAY=:0' >> ~/.bashrc
EOF
cat << EOF | schroot -c debian-armhf
su - mobian
echo "Downloading Box86"
git clone https://github.com/ptitSeb/box86
cd box86

echo "Building Box86"
mkdir build; cd build; cmake .. -DARM_DYNAREC=ON -DCMAKE_BUILD_TYPE=RelWithDebInfo; make
EOF
cat << EOF | schroot -c debian-armhf
su - mobian
echo "Downloading wine"
wget https://twisteros.com/wine.tgz
echo "Extracting wine"
tar zxvf wine.tgz
EOF

echo "alias wine=schroot -c debian-armhf ~/box86/build/box86 ~/wine/bin/wine" >> ~/.bashrc
echo "alias winecfg=schroot -c debian-armhf ~/box86/build/box86 ~/wine/bin/winecfg" >> ~/.bashrc
echo "alias wineboot=schroot -c debian-armhf ~/box86/build/box86 ~/wine/bin/wineboot" >> ~/.bashrc
echo "alias wineconsole=schroot -c debian-armhf ~/box86/build/box86 ~/wine/bin/wineconsole" >> ~/.bashrc
echo "alias winefile=schroot -c debian-armhf ~/box86/build/box86 ~/wine/bin/winefile" >> ~/.bashrc
echo "alias winemine=schroot -c debian-armhf ~/box86/build/box86 ~/wine/bin/winemine" >> ~/.bashrc
echo "Done!"
