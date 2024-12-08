#!/bin/bash

echo "Install script for arch linux"
# updates system
pacman -Syyu

pacman -S ttf-mononoki-nerd alacritty bat dunst lf yazi neovim rofi-wayland wofi zsh tmux variety wlogout
# installs packages to use stow for dotfiles
pacman -S git stow

git clone --recursive git@github.com:shadow-absorber/dotfiles.git

cd dotfiles
stow */
mkdir git
cd git

git clone git@github.com:vinceliuice/Colloid-gtk-theme.git
cd Colloid-gtk-theme
./install.sh --theme red --tweaks catppuccin black
ln -sf $HOME/.local/share/themes/Colloid-Red-Dark-Catppuccin/gtk-4.0/{assets,gtk.css,gtk-dark.css} $HOME/.config/gtk-4.0


cd ../..

bat cache --build
