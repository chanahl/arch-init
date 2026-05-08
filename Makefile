SHELL := /bin/bash

SUDO_PACMAN := sudo pacman -S --needed --noconfirm
YAY := yay --needed --answerclean None --answerdiff None

.PHONY: all init \
	audio browsers chat drivers editors files fonts gaming \
	terminal utilities video

all: \
	audio \
	browsers \
	chat \
	drivers \
	editors \
	files \
	fonts \
	gaming \
	terminal \
	utilities \
	video

init:
	sudo pacman -Syu --noconfirm
	sudo pacman -S --needed base-devel git gcc --noconfirm

	mkdir -p ~/repos/aur
	mkdir -p ~/repos/github

	# st
	cd ~/repos/github && \
		git clone https://github.com/siduck/st.git && \
		cd st && \
		sudo make install

	# yay
	cd ~/repos/aur && \
		git clone https://aur.archlinux.org/yay.git && \
		cd yay && \
		makepkg -si --noconfirm

audio:
	$(SUDO_PACMAN) \
		cava \
		pipewire \
		pipewire-audio \
		pipewire-pulse \
		wireplumber

browsers:
	$(YAY) \
		brave-origin-nightly-bin \
		helium-browser-bin \
		ungoogled-chromium-bin \
		waterfox-bin

chat:
	$(YAY) \
		vesktop \
		zapzap

drivers:
	$(SUDO_PACMAN) \
		linux-headers \
		nvidia-utils lib32-nvidia-utils

editors:
	$(SUDO_PACMAN) neovim

	$(YAY) visual-studio-code-bin

files:
	$(SUDO_PACMAN) \
		dolphin \
		kvantum

fonts:
	$(SUDO_PACMAN) \
		ttf-font-awesome \
		ttf-jetbrains-mono-nerd

gaming:
	$(SUDO_PACMAN) \
		gamescope \
		lutris \
		mangohud \
		lib32-mangohud \
		protontricks \
		steam

	$(YAY) \
		faugus-launcher \
		protonplus

terminal:
	$(SUDO_PACMAN) \
		fastfetch \
		zsh

utilities:
	$(SUDO_PACMAN) \
		7zip \
		feh \
		lact \
		lm_sensors \
		obs-studio \
		openrgb \
		qbittorrent \
		solaar \
		stow \
		xclip \
		wine

	$(YAY) \
		1password \
		bottles \
		nordvpn-bin \
		plasmazones \
		soulseekqt \
		thunderbird-esr-bin

	sudo systemctl enable --now nordvpnd
	sudo usermod -aG nordvpn $$USER
	systemctl --user enable --now plasmazones.service

video:
	$(SUDO_PACMAN) \
		vlc \
		vlc-plugins-all
