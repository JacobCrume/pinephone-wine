#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

apt install figlet
figlet Wine on Pinephone Installer

echo "This script will install wine on your Pinephone. It should take less than 2 hours depending on you internet connection speed."
echo "First we need to install some dependencies."

apt install -y schroot deboostrap

echo "Creating folders"
mkdir /srv/chroot
mkdir /srv/chroot/debian-armhf


echo "Running debootstrap"
debootstrap --arch armhf --foreign buster /srv/chroot/debian-armhf http://debian.xtdv.net/debian

echo "Entering chroot jail"
chroot "/srv/chroot/debian-armhf" /debootstrap/debootstrap --second-stage

echo "Creating configuration files"
cp debian-armhf.conf /etc/schroot/chroot.d
cp nssdatabases /etc/schroot/desktop/nssdatabases
cp stateoverride /srv/chroot/debian-armhf/var/lib/dpkg/statoverride

echo "Entering chroot"
mkdir /srv/chroot/debian-armhf/script
cp wine-chroot-1.sh /srv/chroot/debian-armhf/script
cp wine-chroot-2.sh /srv/chroot/debian-armhf/script
cp wine-chroot-3.sh /srv/chroot/debian-armhf/script
cp wine-chroot-4.sh /srv/chroot/debian-armhf/script
schroot -c debian-armhf /script/wine-chroot-1.sh
schroot -c debian-armhf adduser mobian
schroot -c debian-armhf /script/wine-chroot-2.sh
schroot -c debian-armhf /script/wine-chroot-3.sh
schroot -c debian-armhf /script/wine-chroot-4.sh

echo "alias wine=schroot -c debian-armhf ~/box86/build/box86 ~/wine/bin/wine" >> ~/.bashrc
echo "alias winecfg=schroot -c debian-armhf ~/box86/build/box86 ~/wine/bin/winecfg" >> ~/.bashrc
echo "alias wineboot=schroot -c debian-armhf ~/box86/build/box86 ~/wine/bin/wineboot" >> ~/.bashrc
echo "alias wineconsole=schroot -c debian-armhf ~/box86/build/box86 ~/wine/bin/wineconsole" >> ~/.bashrc
echo "alias winefile=schroot -c debian-armhf ~/box86/build/box86 ~/wine/bin/winefile" >> ~/.bashrc
echo "alias winemine=schroot -c debian-armhf ~/box86/build/box86 ~/wine/bin/winemine" >> ~/.bashrc
echo "Done!"
