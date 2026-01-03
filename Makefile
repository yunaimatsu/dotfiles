SHELL := /bin/bash
MAP_FILE := mapping

# Firefox configuration
FIREFOX_PROFILE := $(HOME)/.mozilla/firefox/a2v38d27.default-release
FIREFOX_CHROME := $(FIREFOX_PROFILE)/chrome
FIREFOX_POLICIES_DIR := /etc/firefox/policies
# DOTFILES_DIR := $(HOME)/$(WORKING_DIR)/dotfiles
DOTFILES_DIR := $(HOME)/working/dotfiles
PKG_DIR := $(DOTFILES_DIR)/packages
MAP_FILE := mapping

# Targets
.PHONY: all mapping firefox firefox-config firefox-extensions firefox-backup help ghx yay nodejs gitconfig python go rust pacman secrets fcitx5-protect fcitx5-unprotect

all: mapping

help:
	@echo "Available targets:"
	@echo "  all              - Setup Qutebrowser and Firefox"
	@echo "  mapping          - Link dotfiles configs"
	@echo "  firefox          - Setup Firefox (config + extensions)"
	@echo "  firefox-config   - Link Firefox configuration files"
	@echo "  firefox-extensions - Install Firefox extensions"
	@echo "  firefox-backup   - Backup Firefox data"
	@echo "  fcitx5-protect   - Make fcitx5 configs read-only"
	@echo "  fcitx5-unprotect - Make fcitx5 configs writable"
	@echo "  help             - Show this help message"

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
	# FIXME: Hide side effects like `==========================`

git-config:
	git config --global user.name "$(GIT_USER_NAME)"
	git config --global user.email "$(GIT_USER_EMAIL)"
	git config --global core.editor "$(GIT_CORE_EDITOR)"
	git config --global core.pager "$(GIT_CORE_PAGER)"
	git config --global filter.lfs.smudge "git-lfs smudge -- %f"
	git config --global filter.lfs.process "git-lfs filter-process"
	git config --global filter.lfs.required true
	git config --global filter.lfs.clean "git-lfs clean -- %f"
	git config --global status.renames true

python:  
	sudo pacman -S python
	sudo pacman -S pyenv

go:
	sudo pacman -S go
	e GOPATH=$$HOME/go
	path $$GOPATH/bin 

rust:
	sudo pacman -S rust

clock:
	sudo ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
	sudo hwclock --systohc

nvim:
	mkdir -p ~/.config/nvim \
	git clone https://github.com/folke/lazy.nvim.git ~/.config/nvim/lazy/lazy.nvim
	CONFIG_DIR="$HOME/.config/nvim"
	INIT_LUA="$CONFIG_DIR/init.lua"

	if [ ! -d "$CONFIG_DIR" ]; then
	  echo "Creating Neovim config directory at $CONFIG_DIR"
	  mkdir -p "$CONFIG_DIR"
	else
	   echo "Neovim config directory already exists."
	fi

android: 
	pkg install git
	pkg install gh
	ssh-keygen
	termux-setup-storage
	git config --global --add safe.directory /storage/emulated/0/*
	cd /storage/emulated/0/
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
mapping:
	@echo "Setting up dotfiles symlinks..."
	@mkdir -p "$$HOME/.aliases" "$$HOME/.secrets" \
		"$$HOME/.config/espanso/config" "$$HOME/.config/espanso/match" \
		"$$HOME/.config/fcitx5/conf" "$$HOME/.config/nvim"
	@while IFS=':' read -r src dest; do \
		[ -z "$$src" ] && continue; \
		src_path="$(DOTFILES_DIR)/$$src"; \
		dest_path=$$(eval echo $$dest); \
		dest_dir=$$(dirname "$$dest_path"); \
		mkdir -p "$$dest_dir" 2>/dev/null || sudo mkdir -p "$$dest_dir"; \
		if [ -L "$$dest_path" ]; then \
			rm -f "$$dest_path" 2>/dev/null || sudo rm -f "$$dest_path"; \
		fi; \
		ln -sf "$$src_path" "$$dest_path" 2>/dev/null || sudo ln -sf "$$src_path" "$$dest_path"; \
		echo "Linked $$src -> $$dest"; \
	done < $(MAP_FILE)
	@echo "Dotfiles symlinks complete!"
	@$(MAKE) fcitx5-protect

# Protect fcitx5 config files from modification by fcitx5-configtool
fcitx5-protect:
	@echo "Protecting fcitx5 configuration files..."
	@chmod 444 $(DOTFILES_DIR)/gui/common/FCITX5_PROFILE
	@chmod 444 $(DOTFILES_DIR)/gui/common/FCITX5_CONFIG
	@chmod 444 $(DOTFILES_DIR)/gui/common/FCITX5_CONF_*.conf
	@echo "fcitx5 configs are now read-only (fcitx5-configtool cannot modify them)"

# Unprotect fcitx5 config files for manual editing
fcitx5-unprotect:
	@echo "Unprotecting fcitx5 configuration files..."
	@chmod 644 $(DOTFILES_DIR)/gui/common/FCITX5_PROFILE
	@chmod 644 $(DOTFILES_DIR)/gui/common/FCITX5_CONFIG
	@chmod 644 $(DOTFILES_DIR)/gui/common/FCITX5_CONF_*.conf
	@echo "fcitx5 configs are now writable"
