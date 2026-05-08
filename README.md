<!-- omit from toc -->
# arch-init

- [ISO](#iso)
- [Installation](#installation)
- [Ctrl+Alt+F3](#ctrlaltf3)
- [Makefile](#makefile)

## ISO

1. Download ISO from https://archlinux.org/download/
2. Copy ISO to Ventoy-enabled USB

## Installation

```sh
<RETURN>
pacman -Sy
pacman -S archinstall
vim /etc/pacman.conf
```

```diff
-ParallelDownloads = 5
+ParallelDownloads = 20
```

```sh
pacman -Sy
archinstall
```

- Archinstall language
  - Language: English (100%)
- Locales
  - Keyboard layout: us
  - Locale language: en_US.UTF-8
  - Locale encoding: UTF-8
- Mirrors and repositories
  - Select regions
    - [x] Canada
  - Optional repositories
    - [x] multilib
- Disk configuration
  - Partitioning
    - Use a best-effort default partition layout
      - /dev/nvme0n1: (__choose the 'os' drive__)
        - [ ] btrfs (super slow)
        - [ ] ext4 (fast and reliable but not as fast as xfs)
        - [x] xfs (cannot resize drive after initialization)
        - [ ] f2fs (wtf is this)
      - Would you like to create a separate partition for /home?
        - No
- Swap
  - Swap on zram: Enabled
  - Compression algorithm: zstd
- Bootloader
  - Bootloader: Limine
  - UKI: Enabled
  - Removable: Enable
- Kernels
  - Kernel: linux
- Hostname
  - Hostname: archlinux
- Authentication
  - Root password: ****
  - User account
    - Add a user
      - Enter a username: achan
      - Enter a password: ****
      - Should "achan" be a superuser (sudo)?
        - Yes
- Profile
  - Type
    - Desktop
      - KDE Plasma
        - plasma-meta (Recommended)
  - Graphics driver
    - [x] Nvidia (open kernel module for newer GPUs, Turing+)
- Applications
  - Audio: pipewire
- Network configuration
  - Use Network Manager (default backend)
- Additional packages
- Timezone
  - America/Toronto
- Automatic time sync (NTP)
  - NTP: Enabled

- Install
  - Installation completed in 1m42s
    - Reboot system

## Ctrl+Alt+F3

```
Arch Linux 7.0.3-arch1-2 (tt3)

archlinux login: achan
Password:
[achan@archlinux ~]]$ _
```

## Makefile

```sh
curl -O https://raw.githubusercontent.com/chanahl/arch-init/master/Makefile
make init
make all
reboot
```
