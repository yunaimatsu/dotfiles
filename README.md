# dotfiles

## Philosophy

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

## Setup Linux
There are several hosts distribute Archlinux ISO images. For most users, `geo.mirror.pkgbuild.com` is the most suitable as it provides intelligent routing to the best available mirror based on your location and network conditions.

### 1. Prepare USB drive
- Buy USB drive at convenience store
- Download Archlinux ISO image from https://geo.mirror.pkgbuild.com/iso/latest.
- Copy the ISO file to USB drive
There are several tools to craft bootable USB Drive
**Etchroid**
on Android
**Ventoy**
https://www.ventoy.net/en/index.html
```sh
paru -S ventoy-bin
sudo ./Ventoy2Disk.sh -i -g /dev/sdX # Replace X with actual sd number
cp alpine-standard-*-x86_64.iso /run/media/$USER/Ventoy/ # Replace * with actual ISO version
```
**`dd` command**
```sh
# Coming soon...
```

### 2. Start LiveCD
- Insert the USB drive to your computer
- Enter firmware-configuration mode
  - Usually UEFI, rarely BIOS (depricated)
- Boot the computer and press `F2` and enter boot-management mode
  - Then you'll enter into live shell mode.
#### 2.1. Setup SSD
```sh
lsblk -f
fdisk -f
mount /dev/sdXn /mnt
```
#### 2.2. Setup network
```sh
iwctl
```
Inside iwctl session:
```sh 
device list
station wlan0 scan
station wlan0 get-networks
station wlan0 connect "yunai"
exit 
```

#### 2.3. Setup users


### 3. Install necessary packages
```sh
pacstrap -K /mnt \
  base linux linux-firmware base-devel sudo networkmanager iwd \
  git unzip which zsh direnv \
  hyprland xdg-desktop-portal-hyprland waybar mako foot \
  pipewire pipewire-pulse pipewire-alsa wireplumber sof-firmware alsa-utils brightnessctl \
  grim slurp wl-clipboard wf-recorder libnotify \
  neovim tree-sitter-cli qutebrowser mpv \
  fcitx5-im fcitx5-mozc fcitx5-hangul fcitx5-chinese-addons fcitx5-unikey \
  cups nss-mdns intel-media-driver \
  noto-fonts noto-fonts-cjk noto-fonts-emoji \
  keyd
arch-chroot /mnt
```

Inside the chroot:
```sh
useradd -m -G wheel -s /usr/bin/zsh yunai
passwd yunai
```
```sh
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

chsh -s $(which zsh) # write login shell to /etc/passwd; takes effect at next login
```

### 3.2. `dotfiles` repository 
```sh
git clone https://github.com/yunaimatsu/dotfiles ~/dotfiles
cd ~/dotfiles
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

# Learning notes
## When Do You Need Modprobe Customization?

**Most users never need it.** Defaults work fine. But you need customization when:

**1. Hardware Conflicts/Bugs**
```bash
# Two drivers fighting for same hardware
blacklist nouveau  # Disable open-source GPU driver to use NVIDIA proprietary

# Driver causing crashes
blacklist pcspkr   # Built-in speaker driver crashing system

# Hardware not being detected
options iwlwifi disable_11ax=1  # Fix specific WiFi chip issues
```

**2. Your Hardware Isn't Loaded by Default**
```bash
# Rare/old hardware not in standard kernel
# You compiled a custom driver and need to force load it
options custom_driver_name param=value
```

**3. Specific Hardware Parameters Needed**
```bash
# RAID controller needs custom firmware path
options megaraid_sas default_queue_depth=256

# USB power management issue
options usbcore autosuspend=-1
```

**Reality check:** On standard Arch with common hardware, you probably won't need modprobe customization. Most issues are solved with:
- Updated kernel (latest -arch package)
- Proper GPU drivers (nvidia, amd, intel packages)
- Standard configuration

## Why Are Modprobe and Sysctl Separate?

This comes down to **what level they control** and **when they act**:

### Different Control Points

```
Boot Timeline:
│
├─ BIOS/Firmware loads
├─ Bootloader (GRUB) loads
├─ Kernel core loads into memory
├─ Kernel initializes (sysctl settings applied)
│  └─ Now the kernel is running, but bare
├─ Modules load (modprobe reads /etc/modprobe.d)
│  └─ Hardware drivers, filesystems, features added
├─ Userspace starts (init, systemd)
└─ Running system
```

**They operate at different stages and on different things.**

### Architectural Reasons

**`modprobe` - Module-specific:**
- Controls **which code loads into kernel**
- Module-level options (each module has different parameters)
- Must happen before module runs (can't change module params after loading)
- Configuration is **module-centric**

```bash
# This is module-specific; doesn't make sense as a global kernel parameter
options iwlwifi disable_11ax=1  # Only applies to iwlwifi
options nvidia NVreg_UsePageAttrTable=1  # Only applies to nvidia
```

**`sysctl` - Kernel behavior:**
- Controls **how the kernel behaves**
- System-wide tuning that applies regardless of modules
- Can be changed at runtime (kernel can adjust on the fly)
- Configuration is **kernel-centric**

```bash
# These apply globally to how kernel handles memory/networking
vm.swappiness = 10              # Affects all processes
net.ipv4.ip_forward = 1         # Affects all networking
kernel.panic = 10               # How kernel panics
```

### Historical Separation

Linux kernel design philosophy:

1. **Monolithic kernel** (core functions always loaded)
2. **Modular extensions** (optional code that can be added/removed)
3. **Tunable parameters** (knobs to adjust behavior)

These are three **conceptually different things**, so they got three different configuration systems:
- Kernel core = compiled, fixed
- Modules = loaded/unloaded dynamically
- Parameters = tuned at runtime

### Practical Implications

```bash
# Modprobe: "Do I need this code at all?"
blacklist nouveau  # Don't even load this

# Sysctl: "I'm using this code, but tune its behavior"
vm.swappiness = 5  # I want less swap usage
```

You could theoretically combine them, but:
- **Complexity increases** – One massive config file
- **Logic gets confused** – Module options vs system tuning mixed together
- **Runtime changes harder** – `sysctl` allows live changes; modules need `modprobe -r`
- **Maintenance nightmare** – Different tools (kernel vs userspace) handle different concerns

### Real Example: Network Card

```
Modprobe decides:
  ✓ Load the e1000 driver (module)
  ✓ With this firmware path

Sysctl tunes:
  ✓ TCP buffer sizes
  ✓ IP forwarding behavior
  ✓ Connection timeouts
```

The driver (modprobe) is one thing. How the kernel *uses* that driver (sysctl) is another.

## Summary

**When you need modprobe customization:**
- Hardware not being recognized
- Driver conflicts
- Specific hardware has buggy firmware/driver
- Rare/custom hardware

**Why they're separate:**
- **Different architectural layers** – Module loading vs kernel tuning
- **Different timing** – Modules loaded once at boot; sysctl can change at runtime
- **Different scope** – Module-specific config vs system-wide config
- **Different tools** – Kernel core vs loadable extensions
- **Historical design** – Reflects how Linux kernel is actually structured

Most users never customize either. When you do need customization, the separation makes sense—they're solving different problems.
