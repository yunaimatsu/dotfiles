#!/bin/zsh

g(){ echo "\033[1;33m$1\033[0m"; }
e(){ echo "export $1=\"$2\"" >> ~/.zshenv; }
p(){ e PATH "$1:\$PATH"; }

cd ~/dotfiles
g "Update package database"

if [ -f /etc/os-release ]; then
  . /etc/os-release
  if [[ "$ID" == "arch" || "$ID_LIKE" == *"arch"* ]]; then
    sudo pacman -Sy
    
    g "Install shell tools"
    for st in $(cat shell-tools.txt); do
      sudo pacman -S --noconfirm --needed "$st"
    done
  elif [[ "$ID" == "debian" || "$ID" == "ubuntu" || "$ID_LIKE" == *"debian"* ]]; then
    sudo apt update
    
    g "Install shell tools"
    for st in $(cat shell-tools.txt); do
      sudo apt install -y "$st"
    done
  else
    echo "Error: This script supports Debian-based and Arch-based systems only."
    echo "Detected OS: $ID"
    exit 1
  fi
else
  echo "Error: Cannot detect OS type. This script requires /etc/os-release file."
  exit 1
fi

g "Mount config files to home directory"
typeset -A files=(
  [ZSHRC]=~/.zshrc
  [ALIASES]=~/.aliases
  [TMUX_CONF]=~/.tmux.conf
  [NEOVIM_INIT.lua]=~/.config/nvim/init.lua
)

for src in "${(@k)files}"; do
  dest="${files[$src]}"
  echo "Linking $src -> $dest"
  ln -sf "$HOME/dotfiles/$src" "$dest"
done

touch ~/.zshenv

e EDITOR nvim
e VISUAL $VISUAL
echo "Enter your GitHub username:"
read USER_NAME_GH
echo "Your username in GitHub is ${USER_NAME_GH}."
e USER_NAME_GH "$USER_NAME_GH"

g "Set up CLI tools"

# Node.js
if [[ "$ID" == "debian" || "$ID" == "ubuntu" || "$ID_LIKE" == *"debian"* ]]; then
  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
  sudo apt install -y nodejs
elif [[ "$ID" == "arch" || "$ID_LIKE" == *"arch"* ]]; then
  sudo pacman -S --noconfirm nodejs npm
fi

# Bun
export BUN_INSTALL="$HOME/.bun" 
export PATH="$BUN_INSTALL/bin:$PATH"
curl -fsSL https://bun.sh/install | bash
p $HOME/.bun/bin

# TS
bun add typescript
bun run tsc --version

# GAS
bun add -g @google/clasp

# Espanso
yay -S espanso
