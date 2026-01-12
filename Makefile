SHELL := /bin/zsh

# DOTFILES_DIR := $(HOME)/$(WORKING_DIR)/dotfiles
DOTFILES_DIR := $(HOME)/working/dotfiles
PKG_DIR := $(DOTFILES_DIR)/packages

define MAPPING_LIST
# cli

# cli/nvim
cli/nvim/init.lua:$$XDG_CONFIG_HOME/nvim/init.lua
# cli/nvim/plugin/XXX:$$XDG_CONFIG_HOME/nvim/plugin/XXX
cli/TMUX_CONF:$$HOME/.tmux.conf
cli/ZSHRC:$$HOME/.zshrc


# gui
gui/arch/ESPANSO_CONFIG_DEFAULT.yml:$$XDG_CONFIG_HOME/espanso/config/default.yml
gui/arch/ESPANSO_MATCH_BASE.yml:$$XDG_CONFIG_HOME/espanso/match/base.yml
gui/arch/ESPANSO_MATCH_IAC.yml:$$XDG_CONFIG_HOME/espanso/match/iac.yml
gui/arch/ESPANSO_MATCH_MATCHES.yml:$$XDG_CONFIG_HOME/espanso/match/matches.yml
gui/arch/KEYD_DEFAULT.conf:/etc/keyd/default.conf

gui/common/fcitx5/profile:$$XDG_CONFIG_HOME/fcitx5/profile
gui/common/fcitx5/config:$$XDG_CONFIG_HOME/fcitx5/config
gui/common/fcitx5/conf/CHTTRANS.conf:$$XDG_CONFIG_HOME/fcitx5/conf/chttrans.conf
gui/common/fcitx5/conf/CLASSICUI.conf:$$XDG_CONFIG_HOME/fcitx5/conf/classicui.conf
gui/common/fcitx5/conf/CLIPBOARD.conf:$$XDG_CONFIG_HOME/fcitx5/conf/clipboard.conf
gui/common/fcitx5/conf/HANGUL.conf:$$XDG_CONFIG_HOME/fcitx5/conf/hangul.conf
gui/common/fcitx5/conf/NOTIFICATION.conf:$$XDG_CONFIG_HOME/fcitx5/conf/notification.conf
gui/common/fcitx5/conf/PINYIN.conf:$$XDG_CONFIG_HOME/fcitx5/conf/pinyin.conf
gui/common/fcitx5/conf/PUNCTUATION.conf:$$XDG_CONFIG_HOME/fcitx5/conf/punctuation.conf

gui/common/foot/foot.ini:$$XDG_CONFIG_HOME/foot/foot.ini

gui/common/HTOP_HTOPRC:$$XDG_CONFIG_HOME/htop/htoprc
gui/common/HYPR_HYPRLAND.conf:$$XDG_CONFIG_HOME/hypr/hyprland.conf
# Mako
gui/common/mako/config:$$XDG_CONFIG_HOME/mako/config
# Neofetch
gui/common/NEOFETCH_CONFIG.conf:$$XDG_CONFIG_HOME/neofetch/config
# Waybar
gui/common/waybar/config:$$XDG_CONFIG_HOME/waybar/config
gui/common/waybar/style.css:$$XDG_CONFIG_HOME/waybar/style.css
endef
export MAPPING_LIST

# Targets
.PHONY: all mapping firefox firefox-config firefox-extensions firefox-backup help ghx yay nodejs gitconfig python go rust pacman secrets fcitx5-protect fcitx5-unprotect ai

all: mapping

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


# Softlink dotfiles
mapping:
	$(call RUN_MAPPING)

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
