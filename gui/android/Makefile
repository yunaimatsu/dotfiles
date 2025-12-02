.PHONY: install git

install:
	ln -sf $(PWD)/.bashrc $(HOME)/.bashrc
	pkg update
	termux-setup-storage
	pkg install -y util-linux
	pkg install -y nvim
	pkg install -y termux-api
	pkg install -y which
	pkg install -y git
	pkg imstall -y nodejs
	pkg install -y python
	pkg install -y mpv
	curl -fsSL https://bun.sh/install | bash
	pip install -U yt-dlp

git:
	git config --global user.name "$(GIT_USER_NAME)"
	git config --global user.email "$(GIT_USER_NAME)@users.noreply.github.com"
	git config --global core.editor "nvim"
	git config --global core.pager "nvim -R"
	git clone --depth 1 git@github.com:yunaimatsu/yunaimatsu.git /sdcard/yunaimatsu
	git clone --depth 1 git@github.com:yunaimatsu/yunaimatsu.github.io.git /sdcard/yunaimatsu.github.io
	git clone git@github.com:yunaimatsu/dotfiles.git /sdcard/dotfiles
	git clone --depth 1 git@github.com:yunaimatsu/memoria.git /sdcard/memoria
	git clone --depth 1 git@github.com:yunaimatsu/documenta.git /sdcard/documenta
	git clone git@github.com:yunaimatsu/munera.git /sdcard/munera
	git clone git@github.com:yunaimatsu/inventarium.git /sdcard/inventarium
	git clone git@github.com:yunaimatsu/fora.git /sdcard/fora


