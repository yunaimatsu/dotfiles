#!/bin/zsh
echo "Mount config files to home directory"
typeset -A files=(
  [ZSHRC]="$HOME/.zshrc"
  [ZSH_PROFILE]="$HOME/.zprofile"
  [ZSH_LOGIN]="$HOME/.zlogin"
  [ZSH_LOGOUT]="$HOME/.zlogout"
  [POWERLEVEL_10K.zsh]="$HOME/.p10k.zsh"
  [ALIASES]="$HOME/.aliases"
  [TMUX_CONF]="$HOME/.tmux.conf"
  [NEOVIM_INIT.lua]="$HOME/.config/nvim/init.lua"
  [ESPANSO_MATCH.yml]="$HOME/.config/espanso/match/base.yml"
  # [KEYD_DEFAULT.conf]="/etc/keyd/default.conf"
  [GIT_CONFIG]="$HOME/.gitconfig" 
  [HYPRLAND_CONFIG.conf]="$HOME/.config/hypr/hyprland.conf"
  [HYPRLAND_PAPER_CONFIG.conf]="$HOME/.config/hypr/hyprpaper.conf"
)
sudo chmod 777 "$HOME/dotfiles/KEYD_DEFAULT.conf"
for src in "${(@k)files}"; do
  dest="${files[$src]}"
  echo "Linking $src -> $dest"
  src_path="$HOME/dotfiles/$src"
  sudo ln -sf "$src_path" "$dest"
done
