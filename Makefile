SHELL := /bin/zsh 

DOTFILES := $(HOME)/dotfiles
ENVDIR := $(DOTFILES)/env
MAPDIR := $(DOTFILES)/map
-include $(wildcard $(ENVDIR)/* ) $(wildcard $(MAPDIR)/* )

ghx:
	@cat $(ENVDIR)/GH_EXTENSIONS | while read plugin; do \
		gh extension install $$plugin; \
	done 

env:
	cd "$$HOME/dotfiles"
	sudo pacman -S --needed --noconfirm base-devel
	for file in $(ENVDIR)/*; do \
		[ -x "$$file" ] && "$$file"; \
		sudo chmod +x "$$file"; \
		st=$$(basename "$$file"); \
		echo "Packages: $$st in $$(which $$st)"; \
		echo "Installing $$st"; \
		sudo pacman -S --needed --noconfirm "$$st"; \
	done

yay:
	echo "Install yay" \
	if command -v yay >/dev/null 2>&1; then \
		echo "yay is already installed." \
	else \
		echo "Installing yay..." \
		cd /tmp \
		git clone https://aur.archlinux.org/yay.git \
		cd yay \
		makepkg -si \
	fi \

nodejs:
	echo "Node.js" \
	sudo pacman -S nodejs \
	echo "npm" \
	sudo pacman -S npm \
	echo "Bun" \
	curl -fsSL https://bun.sh/install | bash \
	path $$HOME/.bun/bin \
	echo "TypeScript" \
	bun add -g typescript \
	tsc --version \
	echo "GAS" \
	bun add -g @google/clasp \
	echo "Gemini" \
	bun 

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

font:
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

# g "Add GUI(Wayland + hypr)"
# p sway swaylock swayidle wayland wl-clipboard foot wofi mako
# p grim slurp wf-recorder xdg-desktop-portal-wlr
# if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then exec Hyprland fi

# g "Set up security configuration"
# p firewalld firejail
# systemctl enable firewalld

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
	sudo pacman -Syu --needed $$(grep -vE '^\s*#|^\s*$$'$(PKG))

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
	echo "Current $VAR_NAME is $VAR_VALUE." \
	read -p "Edit? (y/n) " ANSWER \
	if [[ "$$ANSWER" == "y" ]]; then \
		read -p "Input $$VAR_NAME value" NEW_VALUE \
		cp ~/.zshenv ~/.zshenv.bak \
		if grep -q "^export $$VAR_NAME=" ~/.zshenv; then \
			sed -i '' "s|^export $$VAR_NAME=.*|export $$VAR_NAME=\"$$NEW_VALUE\"|" ~/.zshenv \
		else \
			echo "export $$VAR_NAME=\"$NEW_VALUE\"" >> ~/.zshenv \
		fi \
		echo "$$VAR_NAME を $$NEW_VALUE に更新しました。ターミナルを再起動するか 'source ~/.zshenv' を実行してください。" \
	else \
		echo "Changes canceled." \
	fi

