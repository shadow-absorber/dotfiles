#!/bin/bash

echo "Install script for arch linux"
# updates system
pacman -Syyu

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd $HOME

paru -S noto-fonts-emoji noto-fonts-cjk noto-fonts noto-fonts-extra discord element-desktop
paru -S ttf-mononoki-nerd ghostty bat swaync lf yazi neovim rofi-wayland wofi zsh tmux variety wlogout
paru -S swww
paru -S wlsunset hyprlock hypridle

# installs packages to use stow for dotfiles
paru -S git stow

git clone --recursive git@github.com:shadow-absorber/dotfiles.git

cd dotfiles
stow */
cd $HOME
mkdir git
cd git

git clone git@github.com:vinceliuice/Colloid-gtk-theme.git
cd Colloid-gtk-theme
./install.sh --theme red --tweaks catppuccin black
rm -rf $HOME/.config/gtk-4.0/*
ln -sf $HOME/.local/share/themes/Colloid-Red-Dark-Catppuccin/gtk-4.0/{assets,gtk.css,gtk-dark.css} $HOME/.config/gtk-4.0


cd ../..

bat cache --build
