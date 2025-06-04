#!/bin/zsh

g(){ echo "\033[1;33m$1\033[0m"; }
e(){ echo "export $1=\"$2\"" >> ~/.zshenv; }
p(){ e PATH "$1:\$PATH"; }
w(){ echo "$1" >> "$2" }

cd "$HOME/dotfiles"
g "Update Pacman"
pacman -S sudo:
sudo pacman -Sy

g "Install yay"
sudo pacman -S --needed git base-devel
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

g "Install paru"
cd /tmp
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

g "Install shell tools"
for st in $(cat shell-tools.txt); do
  sudo pacman -Syu "$st"
done

g "Set up network"
systemctl enable NetworkManager

g "Localization"
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

g "Set up fonts"
pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji
pacman -S fcitx5-im fcitx5-mozc fcitx5-configtool

g "Set up X server configuration"
touch "$HOME/.xprofile"
w 'export GTK_IM_MODULE=fcitx' ~/.profile
w 'export QT_IM_MODULE=fcitx' ~/.profile
w 'export XMODIFIERS="@im=fcitx"' ~/.profile
w 'fcitx5 &' ~/.profile

g "Configure clock"
# Change the timezone if you live outside of Japan
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
hwclock --systohc

# g "Add GUI(Wayland + sway)"
# pacman -S sway swaylock swayidle wayland wl-clipboard foot wofi mako
# pacman -S grim slurp wf-recorder xdg-desktop-portal-wlr
# if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then exec sway fi

g "Set up security configuration"
pacman -S firewalld firejail
systemctl enable firewalld

swaymsg reload
echo "Sway config reloaded."

g "Install Neovim"
mkdir -p ~/.config/nvim
git clone https://github.com/folke/lazy.nvim.git ~/.config/nvim/lazy/lazy.nvim

CONFIG_DIR="$HOME/.config/nvim"
INIT_LUA="$CONFIG_DIR/init.lua"

if [ ! -d "$CONFIG_DIR" ]; then
    echo "Creating Neovim config directory at $CONFIG_DIR"
    mkdir -p "$CONFIG_DIR"
else
    echo "Neovim config directory already exists."
fi

g "Set up Espanso"
yay -S espanso



g "Mount config files to home directory"
typeset -A files=(
  [ZSHRC]="$HOME/.zshrc"
  [ALIASES]="$HOME/.aliases"
  [TMUX_CONF]="$HOME/.tmux.conf"
  [NEOVIM_INIT.lua]="$HOME/.config/nvim/init.lua"
  [ESPANSO_MATCH.yml]="$HOME/.config/espanso/match/base.yml"
  # [KEYD_DEFAULT.conf]="/etc/keyd/default.conf"
)
sudo chmod 777 "$HOME/dotfiles/KEYD_DEFAULT.conf"
for src in "${(@k)files}"; do
  dest="${files[$src]}"
  echo "Linking $src -> $dest"
  src_path="$HOME/dotfiles/$src"
  sudo ln -sf "$src_path" "$dest"
done

g "Localization"
sudo locale-gen
sudo localectl set-locale LANG=en_US.UTF-8
sudo localectl set-keymap us
sudo localectl status

g "Setup environment variable file"
touch ~/.zshenv
e EDITOR nvim visudo
e VISUAL $VISUAL

echo "Enter your GitHub username:"
read USER_NAME_GH
echo "Your username in GitHub is ${USER_NAME_GH}."
e USER_NAME_GH "$USER_NAME_GH"

g "Set up programming languages"

g "C/C++"


g "Node.js"
sudo pacman -S nodejs npm

g "Bun"
curl -fsSL https://bun.sh/install | bash
p $HOME/.bun/bin

g "TypeScript"
bun add -g typescript
tsc --version

g "GAS"
bun add -g @google/clasp

g "Python"
g "Go"
g "Rust"
