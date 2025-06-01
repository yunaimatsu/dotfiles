Install Homebrew


### MacOS 
In MacBook, use default MacOS.

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```sh
sudo brew install zsh which git
```

```sh
chsh -s $(which zsh)
```

```sh
git clone https://github.com/yunaimatsu/dotfiles ~/dotfiles
cd ~/dotfiles
chmod +x setup.sh
./setup.sh
```
