DOT := $(HOME)/dotfiles
CFG := $(or $(XDG_CONFIG_HOME),$(HOME)/.config)

.PHONY: init
init:
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
	# Node.js
	curl -fsSL https://bun.sh/install | bash
	bun add -g @google/gemini-cli
	bun add -g @openai/codex
	bun add -g @anthropic-ai/claude-code
