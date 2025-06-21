#!/bin/zsh

w(){ echo "$1" >> "$2" }
g(){ echo "\033[1;33m$1\033[0m"; }
e(){ echo "export $1=\"$2\"" >> ~/.zshenv; }
path(){ e PATH "$1:\$PATH"; }

set -e 

cd "$HOME/dotfiles"
g "Update Pacman"

sudo pacman -Sy --needed pacman
sudo pacman -Syu

p(){ sudo pacman -S --needed --noconfirm "$@" } 
y(){ yay -S --needed --noconfirm "$@" }

g "Packages"
g "Packages: base-devel"
p base-devel
for st in $(cat shelltools.txt); do
  g "Packages: $st in $(which $st)"
  echo "Installing $st"
  p "$st"
done

g "Install yay"
if command -v yay >/dev/null 2>&1; then
  echo "yay is already installed."
else
  echo "Installing yay..."
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
fi

# g "Set up network"
# systemctl enable NetworkManager

# g "Localization"
# echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
# locale-gen
# echo "LANG=en_US.UTF-8" > /etc/locale.conf

clone_base="$HOME/.local/src"
mkdir -p "$clone_base"

ghrepos=(
  yunaimatsu/dotfiles
  zdharma-continuum/zinit
  # add more here
)

for repo in "${ghrepos[@]}"; do
  user=${repo%%/*}
  repo_name=${repo#*/}
  target_dir="$clone_base/$repo_name"

  if [[ ! -d "$target_dir" ]]; then
    echo "Cloning $repo into $target_dir..."
    git clone "https://github.com/$repo.git" "$target_dir"
  else
    echo "Directory $target_dir already exists, skipping clone."
  fi
done

g "Set up fonts"
p noto-fonts noto-fonts-cjk noto-fonts-emoji
p fcitx5-im fcitx5-mozc fcitx5-configtool

g "Set up X server configuration"
touch "$HOME/.xprofile"
w 'export GTK_IM_MODULE=fcitx' ~/.profile
w 'export QT_IM_MODULE=fcitx' ~/.profile
w 'export XMODIFIERS="@im=fcitx"' ~/.profile
w 'fcitx5 &' ~/.profile

# g "Configure clock"
# # Change the timezone if you live outside of Japan
# ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
# hwclock --systohc

# g "Add GUI(Wayland + hypr)"
# p sway swaylock swayidle wayland wl-clipboard foot wofi mako
# p grim slurp wf-recorder xdg-desktop-portal-wlr
# if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then exec Hyprland fi

# g "Set up security configuration"
# p firewalld firejail
# systemctl enable firewalld


# g "Install Neovim"
# mkdir -p ~/.config/nvim
# git clone https://github.com/folke/lazy.nvim.git ~/.config/nvim/lazy/lazy.nvim

# CONFIG_DIR="$HOME/.config/nvim"
# INIT_LUA="$CONFIG_DIR/init.lua"

# if [ ! -d "$CONFIG_DIR" ]; then
#    echo "Creating Neovim config directory at $CONFIG_DIR"
#    mkdir -p "$CONFIG_DIR"
# else
#     echo "Neovim config directory already exists."
# fi

g "Set up Espanso"
y espanso

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

g "Programming Languages"

g "Programming Languages >> Node.js"
p nodejs

g "Programming Languages >> Node.js >> npm"
p npm

g "Programming Languages >> Node.js >> Bun"
curl -fsSL https://bun.sh/install | bash
path $HOME/.bun/bin

g "Programming Languages >> Node.js >> TypeScript"
bun add -g typescript
tsc --version

g "Programming Languages >> Node.js >> GAS"
bun add -g @google/clasp

g "Python"
g "Go"
g "Rust"
