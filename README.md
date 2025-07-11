# Setup
## 1. Setup Linux
### Archlinux
Never use Windows as it is. Always do a clean install of Arch Linux.

## 2. Setup package management tool
### Pacman(For Arch Linux)
```sh
sudo pacman -Syu
```

## 3. Setup shell tools
### 3.1. Zsh 

> Install necessary tools

**Arch**
```sh
sudo pacman -S zsh which
```

> Set Zsh as default shell

```sh
chsh -s $(which zsh)
```
After that, to apply the shell change, please log out once and then log back in as the user.

The `chsh` command modifies the user’s configuration file (for example, the login shell field in `/etc/passwd`), so there is no need to run it every time in files like `.zshrc`.

### 3.2. `dotfiles` repository 
```sh
sudo pacman -S git
```
```sh
git clone https://github.com/yunaimatsu/dotfiles ~/dotfiles
cd ~/dotfiles
```
## Terminal
Uses zsh
- Powerlevel10k
- 3 zsh config files

## Makefile
Makefile docs coming soon!
