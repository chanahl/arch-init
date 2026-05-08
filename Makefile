SHELL := /bin/bash

SUDO_PACMAN := sudo pacman --needed --noconfirm -S
YAY := yes | yay --needed --answerclean None --answerdiff None --mflags "--noconfirm" -S

.PHONY: __init__ __upgrade__ \
	all \
	audio browsers chat drivers editors files fonts gaming \
	terminal utilities video

__init__:
	sudo pacman -Syu --noconfirm
	$(SUDO_PACMAN) base-devel git gcc

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

__upgrade__:
	echo "Upgrading system"
	yay -Syu
	sudo pacman -S archlinux-keyring

	echo "Clearing pacman cache"
	pacman_cache_before=$$(du -sh /var/cache/pacman/pkg/ | cut -f1); \
	paccache -r; \
	echo "Previous cache size: $$pacman_cache_before"

	echo "Removing orphan packages"
	yay -Qdtq | yay -Rns -

	echo "Clearing ~/.cache"
	home_cache_used=$$(du -sh ~/.cache 2>/dev/null | cut -f1); \
	rm -rf ~/.cache/*; \
	echo "Previous cache size: $$home_cache_used"

	echo "Clearing system logs"
	journalctl --vacuum-time=7d

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
		man \
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
