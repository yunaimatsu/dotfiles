SHELL := /bin/zsh
SCRIPT_DIR := shell_scripts
SCRIPTS := $(shell find $(SCRIPT_DIR) -type f -name "*.sh")

all: run-scripts

chmod-scripts:
	@for script in $(SCRIPTS); do \
		echo "Making $$script executable..."; \
		chmod +x "$$script"; \
	done

run-scripts: chmod-scripts
	@for script in $(SCRIPTS); do \
		echo "Running $$script..."; \
		"$$script"; \
	done
