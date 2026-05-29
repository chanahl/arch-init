<!-- omit from toc -->
# arch-init

- [ISO](#iso)
- [Installation](#installation)
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
        - [x] btrfs (super slow)
        - [ ] ext4 (fast and reliable but not as fast as xfs)
        - [ ] xfs (cannot resize drive after initialization)
        - [ ] f2fs (wtf is this)
      - Would you like to use BTRFS subvolumes with a default structure?
        - Yes
      - Would you like to use compression or disable CoW?
        - Use compression
    - BTRFS snapshots
      - Timeshift
- Swap
  - Swap on zram: Enabled
  - Compression algorithm: zstd
- Bootloader
  - Bootloader: Grub
  - UKI: Enabled
  - Removable: Enable
- Kernels
  - Kernel: linux
- Hostname
  - Hostname: hyprarch
- Authentication
  - Root password: ****
  - User account
    - Add a user
      - Enter a username: achan
      - Enter a password: ****
      - Should "achan" be a superuser (sudo)?
        - Yes
- Profile
- Applications
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

```
Arch Linux 7.0.10-arch1-1 (tty1)

itryarchbtw login: achan
Password:
[achan@itryarchbtw ~]]$ _
```

## Makefile

```sh
curl -O https://raw.githubusercontent.com/chanahl/arch-init/master/Makefile
curl -O https://raw.githubusercontent.com/chanahl/arch-init/master/.pkgs
curl -O https://raw.githubusercontent.com/chanahl/arch-init/master/.yays
sudo pacman -S make
reboot
```
