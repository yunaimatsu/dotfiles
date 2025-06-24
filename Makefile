SHELL := /bin/zsh
SCRIPT_DIR := shell_scripts
SCRIPTS := $(shell find $(SCRIPT_DIR) -type f -name "*.sh")

all: chmod

chmod:
	@for script in $(SCRIPTS); do \
		echo "Making $$script executable..."; \
		chmod +x "$$script"; \
	done

run-scripts: chmod
	@for script in $(SCRIPTS); do \
		echo "Running $$script..."; \
		"$$script"; \
	done

mac: chmod
	echo "Mac setup coming soon!"

android: chmod
	echo "Android setup coming soon!"

root: chmod
	echo "Archlinux root setup coming soon!"

user: chmod root
	echo "Archlinux user setup coming soon!"
