# tebby24's arch linux dots

managed by [chezmoi](https://www.chezmoi.io/)

includes configuration for:
- openbox
- zsh
- alacritty
- tmux
- neovim 
- fcitx5

setup for use with a single monitor

## setup a new computer
### install relevant packages
must be performed for __each user__ on the machine
```shell
sudo pacman -Syu chezmoi git
```
```shell
chezmoi init tebby24

```
```shell
chezmoi apply -v
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

### write chezmoi config
create the configuration file
```shell
touch ~/.config/chezmoi/chezmoi.toml
```

fill in the config using the following template

```toml
[data]
    display = "my_display" # xrandr
    wallpaper = "/home/user/path/to/my/wallpaper"
    network_interface = "wlan0" # ip link show   
    chrome_profiles = ["enterted@gmail.com", "tvgonyea@iu.edu"]

[git]
    autoCommit = true
    autoPush = true

[edit]
    apply = true
    command = "nvim"
```
