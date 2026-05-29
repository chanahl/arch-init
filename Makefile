PACMANW := yes '' | sudo pacman --needed --noconfirm -S
PKGS := .pkgs

YAYW := yes '' | yay --needed --answerclean None --answerdiff None --mflags "--noconfirm" -S
YAYS := .yays

.DEFAULT_GOAL := help

help: ## Show targets (make)
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage: make <target>\n  \033[36m\033[0m\n"} /^[$$()% a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

init: ## Initialize Arch Linux
	sudo pacman -Syu --noconfirm
	$(PACMANW) base-devel foot git gcc gpsd openssh vim

	sudo mkdir -p /mnt/d
	sudo mkdir -p /mnt/alpha-prime/srv

	mkdir -p ~/repos/aur
	mkdir -p ~/repos/codeberg/dsge0
	mkdir -p ~/repos/github/chanahl

	# yay
	cd ~/repos/aur && \
		git clone https://aur.archlinux.org/yay.git && \
		cd yay && \
		makepkg -si --noconfirm

list_all: ## Lists all packages to be installed (official and AUR)
	@printf "[pkgs]\n"
# 	@grep -vE '^\s*($|#)' $(PKGS)
	@grep -vE '^\s' $(PKGS)
	@printf "\n[yay]\n"
# 	@grep -vE '^\s*($|#)' $(YAYS)
	@grep -vE '^\s' $(YAYS)

list_pkgs: ## Lists all official packages to be installed
	@grep -vE '^\s*($|#)' $(PKGS)

list_yays: ## Lists all Arch User Repository packages to be installed
	@grep -vE '^\s*($|#)' $(YAYS)

resolve_pkgs: ## Prints sync command for official packages
	@echo "$(PACMANW) $$(grep -vE '^[[:space:]]*($|#)' $(PKGS) | tr -d '\r' | xargs)"

resolve_yays: ## Prints sync command for AUR packages
	@echo "$(YAYW) $$(grep -vE '^[[:space:]]*($|#)' $(YAYS) | tr -d '\r' | xargs)"

sync_pkgs: ## Runs sync command for official package
# 	@grep -vE '^[[:space:]]*($|#)' $(PKGS) | tr -d '\r' | xargs $(PACMANW)
	$(PACMANW) $$(grep -vE '^[[:space:]]*($|#)' $(PKGS) | tr -d '\r' | xargs)

sync_yays: ## Runs sync command for AUR package
# 	@grep -vE '^[[:space:]]*($|#)' $(YAYS) | tr -d '\r' | xargs $(YAYW)
	$(YAYW) $$(grep -vE '^[[:space:]]*($|#)' $(YAYS) | tr -d '\r' | xargs)
