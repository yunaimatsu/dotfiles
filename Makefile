SHELL := /bin/sh

# DOTFILES_DIR := $(HOME)/$(WORKING_DIR)/dotfiles
DOTFILES_DIR := $(HOME)/working/dotfiles
PKG_DIR := $(DOTFILES_DIR)/packages

# Targets
.PHONY: nvim zsh wayland

define RUN_MAPPING
	@mkdir -p "$$HOME/.config/espanso/config"
	@printf '%s\n' "$$MAPPING_LIST" | while IFS= read -r line; do
		[ -z "$$line" ] && continue; \
		echo "$$line" | grep -Eq '^[[:space:]]*#' && continue; \
		IFS=':' read -r src dest <<< "$$line"; \
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
	done
	@echo "Dotfiles symlinks complete!"
	@$(MAKE) fcitx5-protect
endef

zsh:
	@set -e; \
	src_path="$(DOTFILES_DIR)/.zshrc"; \
	dest_path="$$HOME/.zshrc"; \
	ln -sf "$$src_path" "$$dest_path" 2>/dev/null || sudo ln -sf "$$src_path" "$$dest_path"; \
	echo "Linked .zshrc -> $$dest_path";

nvim:
	@set -euo pipefail; \
	NVIM_SRC="$(DOTFILES_DIR)/nvim"; \
	NVIM_DST="$$HOME/.config/nvim"; \
	PKGS="neovim git ripgrep fd unzip base-devel nodejs npm"; \
	\
	mkdir -p "$(HOME)/.config/nvim"; \
	\
	if [ ! -d "$$NVIM_SRC" ]; then \
	  echo "ERROR: not found: $$NVIM_SRC"; \
	  echo "Expected: $$DOTFILES_DIR/nvim"; \
	  exit 1; \
	fi; \
	\
	if [ -L "$$NVIM_DST" ] && [ "$$(readlink -f "$$NVIM_DST")" = "$$(readlink -f "$$NVIM_SRC")" ]; then \
	  echo "[nvim] update (already linked)"; \
	  sudo pacman -Syu --noconfirm; \
	else \
	  echo "[nvim] first-time setup (linking)"; \
	  if [ -e "$$NVIM_DST" ] && [ ! -L "$$NVIM_DST" ]; then \
	    bak="$$NVIM_DST.bak.$$(date +%Y%m%d%H%M%S)"; \
	    echo "[nvim] backup $$NVIM_DST -> $$bak"; \
	    mv "$$NVIM_DST" "$$bak"; \
	  fi; \
	  ln -sfn "$$NVIM_SRC" "$$NVIM_DST"; \
	fi; \
	\
	echo "[nvim] ensure packages"; \
	sudo pacman -S --needed $$PKGS; \
	\
	echo "[nvim] sync lazy/treesitter/mason"; \
	nvim --headless "+Lazy! sync" "+TSUpdate" "+MasonUpdate" "+qa"

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

nodejs:
	@echo "Installing Node.js..."
	@sudo pacman -S --needed nodejs npm
	@if command -v bun >/dev/null 2>&1; then \
		echo "Updating Bun..."; \
		bun upgrade || curl -fsSL https://bun.sh/install | bash; \
	else \
		echo "Installing Bun..."; \
		curl -fsSL https://bun.sh/install | bash; \
	fi
	@echo "Adding TypeScript..."
	@bun add -g typescript
	@tsc --version
	@echo "Adding Clasp(package to execute GAS locally)..."
	@bun add -g @google/clasp 

ai: nodejs
	@set -e; \
	ai() { \
		label="$$1"; pkg="$$2"; bin="$$3"; ver_cmd="$$4"; src="$$5"; dest="$$6"; \
		if command -v "$$bin" >/dev/null 2>&1; then \
			echo "Updating $$label..."; \
		else \
			echo "Installing $$label..."; \
		fi; \
		bun update -g "$$pkg" || bun install -g "$$pkg"; \
		eval "$$ver_cmd"; \
		src_path="$(DOTFILES_DIR)/$$src"; \
		dest_path=$$(eval echo "$$dest"); \
		dest_dir=$$(dirname "$$dest_path"); \
		mkdir -p "$$dest_dir" 2>/dev/null || sudo mkdir -p "$$dest_dir"; \
		if [ -L "$$dest_path" ]; then rm -f "$$dest_path" 2>/dev/null || sudo rm -f "$$dest_path"; fi; \
		ln -sf "$$src_path" "$$dest_path" 2>/dev/null || sudo ln -sf "$$src_path" "$$dest_path"; \
	}; \
	ai \
		"Claude Code by Anthropic" \
		"@anthropic-ai/claude-code" \
		"claude" \
		"claude --version" \
		"ai/claude.toml" \
		"$$HOME/.claude/config.json"; \
	ai \
		"Gemini CLI by Google" \
		"@google/gemini-cli" \
		"gemini" \
		"gemini --version" \
		"ai/gemini.json" \
		"$$HOME/.gemini/settings.json"; \
	ai \
		"Codex by OpenAI" \
		"@openai/codex" \
		"codex" \
		"codex --version" \
		"ai/codex.toml" \
		"$$HOME/.codex/config.toml";

pac:
	@set -e; \
	pac() { \
		src="$$1"; dest="$$2"; \
		src_path="$(DOTFILES_DIR)/$$src"; \
		dest_path="$$dest"; \
		dest_dir=$$(dirname "$$dest_path"); \
		mkdir -p "$$dest_dir" 2>/dev/null || sudo mkdir -p "$$dest_dir"; \
		if [ -e "$$dest_path" ] || [ -L "$$dest_path" ]; then rm -f "$$dest_path" 2>/dev/null || sudo rm -f "$$dest_path"; fi; \
		ln -sf "$$src_path" "$$dest_path" 2>/dev/null || sudo ln -sf "$$src_path" "$$dest_path"; \
	}; \
	pac "pacman/pacman.conf" "/etc/pacman.conf"; \
	pac "paru/paru.conf" "/etc/paru.conf"; \
	pac "paru/makepkg.conf" "/etc/makepkg.conf";

wayland:
	@set -e; \
	link() { \
		src="$$1"; dest="$$2"; \
		src_path="$(DOTFILES_DIR)/$$src"; \
		dest_path=$$(eval echo $$dest); \
		dest_dir=$$(dirname "$$dest_path"); \
		mkdir -p "$$dest_dir" 2>/dev/null || sudo mkdir -p "$$dest_dir"; \
		if [ -L "$$dest_path" ] || [ -e "$$dest_path" ]; then \
			rm -f "$$dest_path" 2>/dev/null || sudo rm -f "$$dest_path"; \
		fi; \
		ln -sf "$$src_path" "$$dest_path" 2>/dev/null || sudo ln -sf "$$src_path" "$$dest_path"; \
		echo "Linked $$src -> $$dest"; \
	}; \
	link "wayland/foot.ini" "$$HOME/.config/foot/foot.ini"; \
	link "wayland/hyprland.conf" "$$HOME/.config/hypr/hyprland.conf"; \
	link "wayland/mako" "$$HOME/.config/mako/config"; \
	link "wayland/waybar/config" "$$HOME/.config/waybar/config"; \
	link "wayland/waybar/style.css" "$$HOME/.config/waybar/style.css"; \
	echo "Wayland symlinks complete!"

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

android: 
	pkg install git
	pkg install gh
	ssh-keygen
	termux-setup-storage
	git config --global --add safe.directory /storage/emulated/0/*
	cd /storage/emulated/0/
	pkg install sshd
	passwd

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
