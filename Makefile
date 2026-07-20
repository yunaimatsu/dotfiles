DOT := $(HOME)/dotfiles
CFG := $(or $(XDG_CONFIG_HOME),$(HOME)/.config)
ETC := /etc

.PHONY: init node python
init:
	# /etc
	sudo mkdir -p "$(ETC)"
	sudo ln -sfn "$(DOT)/etc-pacman.conf" "$(ETC)/pacman.conf"
	sudo mkdir -p "$(ETC)/keyd"
	sudo ln -sfn "$(DOT)/etc-keyd.conf" "$(ETC)/keyd/default.conf"
	sudo ln -sfn "$(DOT)/etc-paru.conf" "$(ETC)/paru.conf"
	sudo ln -sfn "$(DOT)/etc-locale.conf" "$(ETC)/locale.conf"
	sudo ln -sfn "$(DOT)/etc-mkinitcpio.conf" "$(ETC)/mkinitcpio.conf"
	sudo ln -sfn "$(DOT)/etc-vconsole.conf" "$(ETC)/vconsole.conf"
	sudo mkdir -p "$(ETC)/sysctl.d"
	sudo ln -sfn "$(DOT)/etc-sysctld-lowswap.conf" "$(ETC)/sysctl.d/99-lowswap.conf"
	sudo mkdir -p "$(ETC)/sudoers.d"
	sudo ln -sfn "$(DOT)/etc-sudoersd-yunai" "$(ETC)/sudoers.d/99-yunai"
	sudo chmod 0440 "$(ETC)/sudoers.d/99-yunai"
	sudo chown -h root:root "$(ETC)/sudoers.d/99-yunai"
	# Systemd
	# systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service
	# paru
	sudo mkdir -p "$(CFG)/pacman"
	sudo ln -sfn "$(DOT)/etc-makepkg.conf" "$(CFG)/pacman/makepkg.conf"
	# Zsh
	ln -sfn "$(DOT)/.zshrc" "$(HOME)/.zshrc"
	# Neovim
	mkdir -p "$(CFG)/nvim/lua"
	ln -sfn "$(DOT)/nvim-init.lua" "$(CFG)/nvim/init.lua"
	ln -sfn "$(DOT)/nvim-lazylock.json" "$(CFG)/nvim/lazy-lock.json"
	ln -sfn "$(DOT)/nvim-core.lua" "$(CFG)/nvim/lua/core.lua"
	ln -sfn "$(DOT)/nvim-plugins.lua" "$(CFG)/nvim/lua/plugins.lua"
	# Hyprland
	mkdir -p "$(CFG)/hypr"
	ln -sfn "$(DOT)/hyprland.lua" "$(CFG)/hypr/hyprland.lua"
	mkdir -p "$(CFG)/mako"
	ln -sfn "$(DOT)/mako" "$(CFG)/mako/config"
	mkdir -p "$(CFG)/foot"
	ln -sfn "$(DOT)/foot.ini" "$(CFG)/foot/foot.ini"
	mkdir -p "$(CFG)/waybar"
	ln -sfn "$(DOT)/waybar-config" "$(CFG)/waybar/config"
	ln -sfn "$(DOT)/waybar-style.css" "$(CFG)/waybar/style.css"
	# Qutebrowser
	mkdir -p "$(CFG)/qutebrowser"
	ln -sfn "$(DOT)/qute.py" "$(CFG)/qutebrowser/config.py"
	# Fcitx5
	mkdir -p "$(CFG)/fcitx5/conf"
	ln -sfn "$(DOT)/fcitx5-profile" "$(CFG)/fcitx5/profile"
	ln -sfn "$(DOT)/fcitx5-config" "$(CFG)/fcitx5/config"
	for f in chttrans classicui clipboard hangul pinyin punctuation spell unicode waylandim; do \
		ln -sfn "$(DOT)/fcitx5-$$f.conf" "$(CFG)/fcitx5/conf/$$f.conf"; \
	done
	# Audio (PipeWire user services; sockets start the daemons on demand)
	# systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service
	# paru
	echo "Cloning paru..." && \
		cd &&\
		rm -rf paru && \
		mkdir -p "$(CFG)/paru" && \
		git clone https://aur.archlinux.org/paru.git && \
		cd paru && \
		makepkg -si && \
		rm -rf paru

node:
	bun add -g @google/gemini-cli
	bun add -g @openai/codex
	bun add -g @anthropic-ai/claude-code
