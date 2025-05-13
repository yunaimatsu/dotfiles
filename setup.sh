#!/bin/zsh

g(){ echo "\033[1;33m$1\033[0m"; }
e(){ echo "export $1=\"$2\"" >> ~/.zshenv; }
p(){ e PATH "$1:\$PATH"; }

cd ~/dotfiles
g "Updating package database..."
sudo pacman -Sy

g "Install shell tools"
for st in $(cat shell-tools.txt); do
  sudo pacman -S --noconfirm --needed "$st"
done

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
  ln -sf "~/dotfiles/$src" "$dest"
done

touch ~/.zshenv

e EDITOR nvim
e VISUAL $VISUAL
echo "Enter your GitHub username:"
read USER_NAME_GH
echo "Your username in GitHub is ${USER_NAME_GH}."
e USER_NAME_GH "$USER_NAME_GH"

g "Setting up CLI tools..."

# Node.js
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

# Bun
curl -fsSL https://bun.sh/install | bash
p $HOME/.bun/bin

# TS
bun add typescript
bun run tsc --version

# GAS
bun add -g @google/clasp

# Espanso
yay -S espanso
