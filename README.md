# dotfiles

## Env

I use a minimalist, keyboard-driven, setup with tiling window management(Hyprland), optimized for performance and full control via the terminal emulator. Most of my work happens inside Neovim and Foot. Please tailor all code snippets, tool recommendations, and workflow suggestions to this Linux-native terminal-first environment.
Avoid GUI-heavy or Windows/macOS-specific suggestions unless explicitly requested.

- OS: Archlinux
  - Package management: `pacman`
  - AUR helper: `paru`
- Display protocol: Wayland
- Compositor: Hyprland
  - Input Method: fcitx5
  - Expansion Tool: espanso
- Shell: Zsh
- Editor: Neovim
  - Plugin management: `lazy.nvim`
- Version control: git and git-hosting services
  - `gh`
  - `gitea`
  - `gl`

# Setup
## 1. Setup Linux
### Archlinux
- Buy USB drive at convenience store
- Download Archlinux ISO from https://geo.mirror.pkgbuild.com/iso/latest.
- Copy the ISO file to USB drive on Android `Etchroid`
- Insert the USB drive to your computer
- Boot the computer and press `F2` and enter boot-management mode
  - Then you'll enter into live shell mode.

```sh
lsblk -f
mount /dev/sdXn /mnt
pacstrap -K /mnt \
  base linux linux-firmware base-devel sudo networkmanager iwd \
  git unzip which zsh direnv \
  hyprland xdg-desktop-portal-hyprland waybar mako foot \
  pipewire pipewire-pulse pipewire-alsa wireplumber sof-firmware alsa-utils brightnessctl \
  grim slurp wl-clipboard wf-recorder libnotify \
  neovim tree-sitter-cli qutebrowser mpv \
  fcitx5-im fcitx5-mozc fcitx5-hangul fcitx5-chinese-addons fcitx5-unikey \
  cups nss-mdns intel-media-driver \
  noto-fonts noto-fonts-cjk noto-fonts-emoji
arch-chroot /mnt
```

Inside the chroot:

```sh
useradd -m -G wheel -s /usr/bin/zsh yunai # create user with zsh as login shell
passwd yunai # set user password
chsh -s /usr/bin/zsh # set zsh for root too (optional)
printf '[device]\nwifi.backend=iwd\n' > /etc/NetworkManager/conf.d/wifi-backend.conf # switch wifi backend to iwd permanently
systemctl enable NetworkManager # start network management at boot
```

## 2. Setup package management tool
### Pacman(For Arch Linux)
```sh
sudo pacman -Syu
```

## 3. Setup shell tools
### 3.1. Zsh

On Arch this is already done: `pacstrap` installs zsh and `useradd -s /usr/bin/zsh` set it as the login shell during step 1.

On an existing system where that didn't happen:

```sh
sudo pacman -S zsh which
chsh -s $(which zsh) # write login shell to /etc/passwd; takes effect at next login
```

### 3.2. `dotfiles` repository 
```sh
sudo pacman -S git
```
```sh
git clone https://github.com/yunaimatsu/dotfiles ~/dotfiles
cd ~/dotfiles
export DOTFILES_DIR="$HOME/dotfiles"
```
## Terminal
Uses zsh
- Powerlevel10k
- 3 zsh config files

## Makefile
Makefile docs coming soon!

# Commenting rule
- Do not use dedicated comment lines.
- Write comments inline only, after code.
- Format: <infinitive verb> <object> <adverb(optional)>
  - `echo Hello # output message clearly`
  - `cp file.txt backup.txt # create backup locally`
