#!/bin/zsh

g(){ echo "\033[1;33m$1\033[0m"; }
e(){ echo "export $1=\"$2\"" >> ~/.zshenv; }
p(){ e PATH "$1:\$PATH"; }

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

g "Install shell tools"
for st in $(cat shell-tools.txt); do
  sudo pacman -Syu "$st"
done

g "Mount config files to home directory"
typeset -A files=(
  [ZSHRC]="$HOME/.zshrc"
  [ALIASES]="$HOME/.aliases"
  [TMUX_CONF]="$HOME/.tmux.conf"
  [NEOVIM_INIT.lua]="$HOME/.config/nvim/init.lua"
)
for src in "${(@k)files}"; do
  dest="${files[$src]}"
  echo "Linking $src -> $dest"
  ln -sf "~/dotfiles/$src" "$dest"
done

g "Setup environment variable file"
touch ~/.zshenv
e EDITOR nvim
e VISUAL $VISUAL
echo "Enter your GitHub username:"
read USER_NAME_GH
echo "Your username in GitHub is ${USER_NAME_GH}."
e USER_NAME_GH "$USER_NAME_GH"

g "Set up programming languages"

g "Node.js"
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt install -y nodejs

g "Bun"
curl -fsSL https://bun.sh/install | bash
p $HOME/.bun/bin

g "TypeScript"
bun add typescript
bun run tsc --version

g "GAS"
bun add -g @google/clasp

g "Espanso"
yay -S espanso
