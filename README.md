# dotfiles
One command. Zero waste. The ultimate setup.

## 1. Setup Linux
### Windows
> Clean-installaton

Comming soon...

> WSL2
```Powershell
wsl --install -d Debian
echo 'WSL & Debian installed'
wsl --set-default Debian
echo 'Debian is set as default distribution'
wsl --set-default-version 2
echo 'WSL version is set 2'
echo '=== [ Current distributions ] ==='
wsl -l -v
echo 'Starting Debian...'
wsl -d Debian
```

### MacOS 
In MacBook, use default MacOS.

## 2. Setup package management tool
### Arch Linux (Pacman)
```sh
sudo pacman -Syu
```
### MacOS (Homebrew)
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
## 3. Setup shell tools
### 3.1. Zsh 

> Install necessary tools

```sh
sudo pacman -S zsh which chsh # Arch
sudo brew install zsh which chsh # Mac
```

> Set Zsh as default shell

```sh
chsh -s $(which zsh)
```
After that, to apply the shell change, please log out once and then log back in as the user.

The `chsh` command modifies the user’s configuration file (for example, the login shell field in `/etc/passwd`), so there is no need to run it every time in files like `.zshrc`.


### 3.2. `dotfiles` repository 
```sh
sudo pacman -S git # Arch
sudo brew install git # Mac
```
```sh
git clone https://github.com/yunaimatsu/dotfiles ~/dotfiles
```

