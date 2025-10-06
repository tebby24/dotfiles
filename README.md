# tebby24's arch linux dots

includes configuration for:
- labwc
- zsh
- alacritty
- tmux
- neovim 
- chinese input?

## clone the dotfiles
must be performed for each user on the machine

## other configuration

### setup AUR helper
```shell
mkdir ~/aur-builds && cd ~/aur-builds
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

### setup ssh key with github
this is necessary to push dotfile changes to the remote repo

generate an ssh key
```shell
ssh-keygen -t ed25519 -C "enterted@gmail.com"
```

copy the public key to your clipboard
```shell
xclip -selection clipboard < ~/.ssh/id_ed25519.pub
```
navigate to https://github.com/settings/ssh/new

title the SSH key: _hostname (username)_

determine your machine's hostname with `cat /etc/hostname`

