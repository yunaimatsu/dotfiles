SHELL := /bin/zsh 
DOTFILES := $(HOME)/dotfiles
MAPFILE := $(DOTFILES)/MAP
PKG := $(DOTFILES)/PKG

archuser: 
	cd "$$HOME/dotfiles"
	sudo pacman -S --needed --noconfirm base-devel
	@for file in "$$HOME/dotfiles/*.sh"; do \
		[ -x "$$file" ] && "$$file" \
		echo "Packages: $$st in $$(which $$st)" \
		echo "Installing $$st" \
		p "$$st" \
	done
	@echo "Install yay" \
	if command -v yay >/dev/null 2>&1; then \
		echo "yay is already installed." \
	else \
		echo "Installing yay..." \
		cd /tmp \
		git clone https://aur.archlinux.org/yay.git \
		cd yay \
		makepkg -si \
	fi \
	echo "Set up Espanso" \
	yay -S --needed --noconfirm espanso 
	echo "Programming Languages"
	echo "Programming Languages >> Node.js"
	p nodejs
	echo "Programming Languages >> Node.js >> npm"
	p npm
	echo "Programming Languages >> Node.js >> Bun"
	curl -fsSL https://bun.sh/install | bash
	path $$HOME/.bun/bin
	echo "Programming Languages >> Node.js >> TypeScript"
	bun add -g typescript
	tsc --version
	echo "Programming Languages >> Node.js >> GAS"
	bun add -g @google/clasp
	echo "Python"
	sudo p -S python
	sudo p -S pyenv
	echo "Go"
	sudo p -S go
	e GOPATH=$$HOME/go
	path $$GOPATH/bin 
	echo "Rust"
	sudo p -S rust

# Void Linux
voidroot: 
	echo "Void root setup coming soon!"

voiduser:  voidroot
	echo "Void user setup coming soon!"

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
	sudo pacman -Syu --needed $$(grep -vE '^\s*#|^\s*$$'$(PKG))

# Cross-distro

# Softlink dotfiles
map:
	while IFS=':' read -r src dest; do \
		echo "Linking $$src -> $$dest"; \
		src_path="$(DOTFILES)/$$src"; \
		dest_path=$$(eval echo $$dest); \
		sudo ln -sf "$$src_path" "$$dest_path"; \
	done < $(MAPFILE)

env:
	VAR_NAME="USER_NAME_GH" \
	VAR_VALUE="${!VAR_NAME}" \
	if [ -z "$VAR_VALUE" ]; then \
		echo "環境変数 $VAR_NAME は存在しません。" \
		exit 1 \
	fi \
	echo "あなたの $VAR_NAME は $VAR_VALUE です。" \
	read -p "変更しますか？(y/n) " ANSWER \
	if [[ "$ANSWER" == "y" ]]; then \
		read -p "$VAR_NAME の値を入力してください: " NEW_VALUE \
		cp ~/.zshenv ~/.zshenv.bak \
		if grep -q "^export $VAR_NAME=" ~/.zshenv; then \
			sed -i '' "s|^export $VAR_NAME=.*|export $VAR_NAME=\"$NEW_VALUE\"|" ~/.zshenv \
		else \
			echo "export $VAR_NAME=\"$NEW_VALUE\"" >> ~/.zshenv \
		fi \
		echo "$VAR_NAME を $NEW_VALUE に更新しました。ターミナルを再起動するか 'source ~/.zshenv' を実行してください。" \
	else \
		echo "変更をキャンセルしました。" \
	fi
	echo "Setup environment variable file" \
	echo "Enter your GitHub username:" \
	read USER_NAME_GH \
	echo "Your username in GitHub is $${USER_NAME_GH}." \
	export USER_NAME_GH "$$USER_NAME_GH" \
	GIT_EMAIL="${USER_NAME_GH}@users.noreply.github.com"
	git config --global user.name "$USER_NAME_GH"
	git config --global user.email "$GIT_EMAIL"
