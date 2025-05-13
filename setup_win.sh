#!/bin/zsh

# Mount configuration files

green(){
  echo "\033[0;32m$1\033[0m"
}
green "Mounting Windows configuration files to home directory..."

cd ~/dotfiles

typeset -A path=(
  [ALIASES_WIN]=~/.aliases_win
)

for src in "${(@k)path}"; do
  dest="${path[$src]}"
  echo "Linking $src -> $dest"
  ln -sf "~/dotfiles/$src" "$dest"
done
