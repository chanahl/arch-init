#!/bin/bash

sudo pacman -Syu --noconfirm
sudo pacman -S base-devel gd git --noconfirm

mkdir -p ~/repos/{aur,github}

# st
cd ~/repos/github/
mkdir siduck; cd siduck
git clone https://github.com/siduck/st.git
cd st
sudo make install

# yay
cd ~/repos/aur/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

reboot
