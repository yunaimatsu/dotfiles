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
  - Plugin manager: `zinit`
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
mount /dev/sdXn/XXX /mnt
arch-chroot
pacstrap -K 
```

TODO: complete `pacstrap` command; install git, basedevil, hyprland, foot, mako, waybar, fcitx5, unzip, nvim, qutebrowser

## 2. Setup package management tool
### Pacman(For Arch Linux)
```sh
sudo pacman -Syu
```

## 3. Setup shell tools
### 3.1. Zsh 

> Install necessary tools

**Arch**
```sh
sudo pacman -S zsh which
```

> Set Zsh as default shell

```sh
chsh -s $(which zsh)
```
After that, to apply the shell change, please log out once and then log back in as the user.

The `chsh` command modifies the user’s configuration file (for example, the login shell field in `/etc/passwd`), so there is no need to run it every time in files like `.zshrc`.

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
