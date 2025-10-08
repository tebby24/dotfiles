# tebby24's arch linux dots

managed by [chezmoi](https://www.chezmoi.io/)

includes configuration for:
- labwc
- zsh
- alacritty
- tmux
- neovim 
- fcitx5

## setup a new computer
### install relevant packages
must be performed for each user on the machine
```shell
sudo pacman -Syu chezmoi git
```
```shell
chezmoi init tebby24

```
```shell
chezmoi apply -v
```

## other configuration

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

