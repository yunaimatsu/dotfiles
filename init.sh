#!/bin/sh
ln -sfn "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
ln -sfn "$HOME/dotfiles/hyprland.lua" "${XDG_CONFIG_HOME:-$HOME/.config}/hypr/hyprland.lua"
