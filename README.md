# Dotfiles
A repository of shadows dotfiles.

## Installing required packages

You will need `git` and GNU `stow`

To install both on arch:
```bash
pacman -S git stow
```

To install both on Fedora:
```bash
sudo dnf install git stow
```

To install both on Ubuntu:
```bash
sudo apt install git stow
```

To install both on Debian:
```bash
sudo apt install git stow
```


## Using stow to handle dotfiles

Run `stow` to symlink contents of the dotfiles folder
to your home folder:

```bash
stow */ # Every folder will be included but not the README
```

To just use some specific config files do the following:

```bash
stow zsh # Would just use the zsh config
```

### More info
For more info contact shadow on discord.
