# dotfiles
One command. Zero waste. The ultimate setup.

# 1. Setup Linux
## Windows
### Clean-installaton
### WSL2
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

## MacOS 
`FIXME`: In MacBook, default MacBook is used.

# 2. Setup package management tool
## Arch Linux (Pacman)
```sh
pacman -Syu
```
## MacOS (Homebrew)
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
# 3. Setup shell tools
## 3.1. Zsh 
```sh
sudo pacman -S zsh
```
```sh
sudo brew install zsh
```
## 3.2. `dotfiles` repository 
```sh
sudo packman -S git # Arch
sudo brew git # MacOS
```
```sh
git clone https://github.com/yunaimatsu/dotfiles ~/dotfiles
```
