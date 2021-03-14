#!/bin/bash
su - mobian
echo "You need to enter your password. This is used for the 32 bit arm root account"
passwd mobian
printf 'export LANGUAGE="C"\nexport LC_ALL="C"\nexport DISPLAY=:0' >> ~/.bashrc
exit
