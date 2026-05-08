yay --answerclean None --answerdiff None \
  # browsers
  brave-origin-nightly-bin \
  helium-browser-bin \
  ungoogled-chromium-bin \
  waterfox-bin \

  # chat
  vesktop \
  zapzap \

  # compatibility
  bottles \
  wine \

  # editors
  visual-studio-code-bin \

  # gaming
  faugus-launcher \
  protonplus \

  # utilties
  1password \
  nordvpn-bin \
  plasmazones \
  soulseekqt \
  thunderbird-esr-bin

sudo systemctl enable --now nordvpnd
sudo usermod -aG nordvpn $USER

sudo systemctl --user enable --now plasmazones.service
