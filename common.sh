#!/bin/zsh

g(){ echo "\033[1;33m$1\033[0m"; }
e(){ echo "export $1=\"$2\"" >> ~/.zshenv; }
# p(){ e PATH "$1:\$PATH"; }
w(){ echo "$1" >> "$2" }

