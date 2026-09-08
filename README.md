# tebby24's arch linux dots

managed by [chezmoi](https://www.chezmoi.io/)

includes configuration for:
- openbox
- zsh
- alacritty
- tmux
- neovim 
- rofi
- fcitx5

setup for use with a single monitor

## setup a new computer
### install relevant packages
```shell
sudo pacman -Syu chezmoi git
```
```shell
chezmoi init tebby24
```
```shell
chezmoi apply -v --exclude=encrypted
```

### enable LightDM at boot
```shell
sudo systemctl enable lightdm
```


### setup ssh key with github
must be performed for __each user__ on the machine
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

### configure keyd
enable and start keyd in systemd
```shell
sudo systemctl enable keyd --now
```

paste the following into `/etc/keyd/default.conf`:
```shell
[ids]
*

[main]

capslock = leftcontrol
leftcontrol = capslock

leftalt = leftmeta
leftmeta = leftalt
```

### write chezmoi config
create the configuration file
```shell
touch ~/.config/chezmoi/chezmoi.toml
```

fill in the config using the following template

```toml
encryption = "age"

[data]
network_interface = "wlan0"
wallpaper = "minami-ke.jpg"
chrome_profiles = ["enterted@gmail.com", "tvgonyea@iu.edu"]

[git]
autoCommit = true
autoPush = true

[edit]
apply = true
command = "nvim"

[age]
identity = "~/.config/chezmoi/key.txt"
recipient = "age1hqpw2dl4k3gxjjj22nldl3vgua4dfmlej94lfqfkr8vj4n44fv5qkecz84"
```
