#!/bin/bash

# Update
echo "Update Void.."
sudo xbps-install void-repo-nonfree void-repo-multilib-nonfree void-repo-multilib xtools -y
sudo xbps-install -Su -y

# Install required packages
echo "Install required packages.."
sudo xbps-install -S -y nano xrandr bluez blueman libspa-bluetooth vlc uget redshift redshift-gtk kitty bash-completion freerdp font-kacst SDL2_ttf unzip unrar git neofetch

# Set up pipewire service
#echo "/usr/bin/pipewire &" >> .xinitrc
#echo "/usr/bin/pipewire-pulse &" >> .xinitrc
#echo "/usr/bin/wireplumber &" >> .xinitrc
#echo "while true; do" >> ~/.xinitrc
#echo "   dwm > /dev/null 2>&1" >> .xinitrc
#echo "done" >> ~/.xinitrc

# Enable Bluetooth services
echo "Enable Bluetooth services..."
sudo rfkill unblock bluetooth
sudo ln -s /etc/sv/bluetoothd /var/service/

# Add bash completion source line to .bashrc
echo "Add bash completion source line to .bashrc..."
echo "source /usr/share/bash-completion/bash_completion" >> .bashrc
source ~/.bashrc

# Installing fonts...
echo "Restore XFCE settings..."
sudo curl -L -o fonts.tar.gz https://github.com/emadadel4/Void-Linux/raw/refs/heads/main/fonts.tar.gz
sleep 2
tar -xzvf fonts.tar.gz -C .local/share


# Restore XFCE settings
echo "Restore XFCE settings..."
sudo curl -L -o xfce4-config.tar.gz https://github.com/emadadel4/Void-Linux/raw/refs/heads/main/xfce4-config.tar.gz
sleep 2
tar -xzvf xfce4-config.tar.gz

