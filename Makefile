SHELL := /bin/bash

SUDO_PACMAN := yes '' | sudo pacman --needed --noconfirm -S
YAY := yes '' | yay --needed --answerclean None --answerdiff None --mflags "--noconfirm" -S

.PHONY: __init__ __upgrade__ \
	all \
	audio browsers chat drivers editors files fonts gaming terminal tui utilities video

__init__:
	sudo pacman -Syu --noconfirm
	$(SUDO_PACMAN) base-devel foot git gcc gpsd openssh vim

	mkdir -p /mnt/d
	mkdir -p /mnt/alpha-prime/srv

	mkdir -p ~/repos/aur
	mkdir -p ~/repos/github/chanahl

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
	hyprland \
	terminal \
  tui \
	utilities \
	video

audio:
	$(SUDO_PACMAN) \
		cava \
		mpd \
		pamixer \
		pavucontrol \
		pipewire \
		pipewire-audio \
		pipewire-pulse \
		qpwgraph \
		wireplumber

	$(YAY) \
		cantata \
		qt6-base qt6-declarative qt6-positioning

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
		egl-wayland \
		linux-headers \
		nvidia-dkms nvidia-utils lib32-nvidia-utils libva-nvidia-driver

editors:
	$(SUDO_PACMAN) neovim
	git clone https://github.com/LazyVim/starter ~/.config/nvim
	rm -rf ~/.config/nvim/.git

	$(YAY) visual-studio-code-bin

files:
	$(SUDO_PACMAN) \
		dolphin

fonts:
	$(SUDO_PACMAN) \
		ttf-jetbrains-mono-nerd \
		noto-fonts noto-fonts-cjk noto-fonts-emoji

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

hyprland:
	$(SUDO_PACMAN) \
		hyprland \
		hyprlock \
		hyprpaper \
		hyprpolkitagent \
		qt5-wayland \
		qt6-wayland \
		xdg-desktop-portal \
		xdg-desktop-portal-hyprland

	$(YAY) \
		bibata-cursor-theme-bin \
		nordic-theme \
		orbit-wifi \
		waybar-cava-git \
		waybar-module-pacman-updates-git

terminal:
	$(SUDO_PACMAN) \
		fastfetch

	curl -s https://ohmyposh.dev/install.sh | bash -s

tui:
	$(SUDO_PACMAN) \
		yazi \
		7zip \
		fd \
		ffmpeg \
		fzf \
		imagemagick \
		jq \
		poppler \
		resvg \
		ripgrep \
		xclip \
		zoxide

utilities:
	$(SUDO_PACMAN) \
		7zip \
		bluez bluez-utils \
		btop \
		cifs-utils \
		ddcutil \
		feh \
		grim \
		keychain \
		kvantum \
		lact \
		libnotify \
		lm_sensors \
		man \
		nwg-look \
		obs-studio \
		openrgb \
		qbittorrent \
		rofi \
		slurp \
		solaar \
		stow \
		swaync \
		tailscale \
		xclip \
		wget \
		wine \
		wl-clipboard

	$(YAY) \
		1password \
		bottles \
		nordvpn-bin \
		qt6ct-kde \
		soulseekqt \
		sunshine \
		thunderbird-esr-bin

video:
	$(SUDO_PACMAN) \
		vlc \
		vlc-plugins-all
