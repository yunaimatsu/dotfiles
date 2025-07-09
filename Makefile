SHELL := /bin/zsh 

DOTFILES := $(HOME)/dotfiles
PKG_DIR := $(DOTFILES)/packages
MAP_FILE := mapping

ghx:
	@cat $(PKG_DIR)/GH_EXTENSIONS | while read plugin; do \
		gh extension install $$plugin; \
	done 

yay:
	echo "Install yay" \
	if command -v yay >/dev/null 2>&1; then \
		echo "yay is already installed." \
	else \
		cd /tmp \
		git clone https://aur.archlinux.org/yay.git \
		cd yay \
		makepkg -si \
	fi \

nodejs:
	sudo pacman -S nodejs \
	sudo pacman -S npm \
	curl -fsSL https://bun.sh/install | bash \
	path $$HOME/.bun/bin \
	bun add -g typescript \
	tsc --version \
	bun add -g @google/clasp \
	gemini -v

gitconfig:
	@git config --global user.name "$(GIT_USER_NAME)"
	@git config --global user.email "$(GIT_USER_EMAIL)"
	@git config --global core.editor "$(GIT_CORE_EDITOR)"
	@git config --global core.pager "$(GIT_CORE_PAGER)"
	git config --list

python:  
	echo "Python"
	sudo pacman -S python
	sudo pacman -S pyenv

go:
	echo "Go"
	sudo pacman -S go
	e GOPATH=$$HOME/go
	path $$GOPATH/bin 

rust:
	echo "Rust"
	sudo pacman -S rust

# Void Linux
voidroot: 
	echo "Void root setup coming soon!"

voiduser:  voidroot
	echo "Void user setup coming soon!"

# FIXME: Install C/C++ in distro without systemd

nw:
# systemctl enable NetworkManager

locale:
	echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
	locale-gen
	echo "LANG=en_US.UTF-8" > /etc/locale.conf
	sudo localectl set-locale LANG=en_US.UTF-8
	sudo localectl set-keymap us
	sudo localectl status

fonts:
	sudo pacman -S noto-fonts noto-fonts-cjk noto-fonts-emoji
	sudo pacman -S fcitx5-im fcitx5-mozc fcitx5-configtool

x:
	touch "$HOME/.xprofile"
	w 'export GTK_IM_MODULE=fcitx' ~/.profile
	w 'export QT_IM_MODULE=fcitx' ~/.profile
	w 'export XMODIFIERS="@im=fcitx"' ~/.profile
	w 'fcitx5 &' ~/.profile

clock:
	ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
	hwclock --systohc

nvim:
	echo "Neovim recipe coming soon!"
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

# Android
android: 
	pkg install git
	pkg install gh
	ssh-keygen
	termux-setup-storage
	git config --global --add safe.directory /storage/emulated/0/*
	cd /storage/emulated/0/
	echo "Enable termux sshd"
	pkg install sshd
	passwd

# Archlinux
pacman:
	@while read -r pkg; do \
		if ! pacman -Qi $$pkg > /dev/null 2>&1; then \
			echo "Installing $$pkg..."; \
			sudo pacman -S --noconfirm --needed $$pkg; \
		else \
			echo "$$pkg is already installed.";\
		fi; \
	done < $(PKG_DIR)/PACMAN_PKG

# Softlink dotfiles
map:
	@while IFS=':' read -r src dest; do \
		src_path="$(DOTFILES)/$$src"; \
		dest_path=$$(eval echo $$dest); \
		sudo ln -sf "$$src_path" "$$dest_path"; \
		echo "Linked $$src -> $$dest"; \
	done < $(MAP_FILE)

env:
	cd "$$HOME/dotfiles"
	cp .env.example .env

