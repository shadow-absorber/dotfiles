#!/bin/bash

echo "Install script for arch linux"
# updates system
pacman -Syyu

git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd $HOME

paru -S bat beets btop catppuccin-cursors-mocha cava clamav cliphist darkly dhex dictd discord element-desktop eza fastfetch ffmpegthumbnailer fzf ghostty gnome-disk-utility grim grimblast-git hypridle hyprland hyprlock imagemagick keepassxc kitty less libqalculate librewolf-bin mangohud mpd mpd-discord-rpc mpd-mpris mpv mullvad-vpn-bin neovim noto-fonts-cjk noto-fonts-emoji noto-fonts-extra nsxiv nwg-look papirus-folders-catppuccin-git pavucontrol perl-image-exiftool pika-backup pkgfile plocate ploopy-headphones-toolbox-bin qmk qt5ct qt6ct rmpc rofi slurp steam swappy swaync swww tealdeer thunar thunar-archive-plugin thunar-media-tags-plugin thunderbird tmux ttf-dejavu ttf-dejavu-nerd ttf-liberation ttf-mononoki-nerd tumbler vial-appimage vim vlc vlc-plugins-all waybar wget wl-clipboard wlogout wlsunset wofi xarchiver xdg-desktop-portal-hyprland xdg-utils yazi zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps zoxide zsh zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting zsh-you-should-use

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
