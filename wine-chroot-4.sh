#!/bin/bash

echo "Downloading wine"
wget https://twisteros.com/wine.tgz
echo "Extracting wine"
tar zxvf wine.tgz
echo "Installing wine dependencies"
apt install -y zenity
exit
